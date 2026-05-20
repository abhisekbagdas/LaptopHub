package com.icp.laptophub.controller;

import com.icp.laptophub.dao.CartDao;
import com.icp.laptophub.dao.CartDaoImpl;
import com.icp.laptophub.dao.OrderDao;
import com.icp.laptophub.dao.OrderDaoImpl;
import com.icp.laptophub.dao.UserDao;
import com.icp.laptophub.dao.UserDaoImpl;
import com.icp.laptophub.model.CartItem;
import com.icp.laptophub.model.Order;
import com.icp.laptophub.model.User;
import com.icp.laptophub.utils.PasswordUtil;
import com.icp.laptophub.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

@WebServlet("/profile")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,     // 1 MB
        maxFileSize = 1024 * 1024 * 5,        // 5 MB
        maxRequestSize = 1024 * 1024 * 10     // 10 MB
)
public class ProfileServlet extends HttpServlet {

    private final UserDao userDao = new UserDaoImpl();
    private final CartDao cartDao = new CartDaoImpl();
    private final OrderDao orderDao = new OrderDaoImpl();

    private static final String UPLOAD_DIR = "static/uploads/profiles";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User sessionUser = (User) SessionUtil.getAttribute(request, "user");
        if (sessionUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Fetch fresh user data from the database
        User freshUser = userDao.findByUsername(sessionUser.getUsername());
        if (freshUser != null) {
            request.setAttribute("profileUser", freshUser);
        } else {
            request.setAttribute("profileUser", sessionUser);
        }

        // Fetch user's cart items for the "In Cart" section
        List<CartItem> cartItems = cartDao.fetchAllCartItemsByUser(sessionUser.getId());
        request.setAttribute("cartItems", cartItems);

        // Fetch user's actual bought orders for the "Recent Orders" section
        List<Order> recentOrders = orderDao.findOrdersByUserId(sessionUser.getId());
        request.setAttribute("recentOrders", recentOrders);

        // Check if user is admin
        request.setAttribute("isAdmin", "admin@example.com".equals(sessionUser.getEmail()));

        request.getRequestDispatcher("/WEB-INF/views/profile.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User sessionUser = (User) SessionUtil.getAttribute(request, "user");
        if (sessionUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if ("updateProfile".equals(action)) {
            handleUpdateProfile(request, response, sessionUser);
        } else if ("changePassword".equals(action)) {
            handleChangePassword(request, response, sessionUser);
        } else if ("uploadPhoto".equals(action)) {
            handleUploadPhoto(request, response, sessionUser);
        } else {
            response.sendRedirect(request.getContextPath() + "/profile");
        }
    }

    private void handleUploadPhoto(HttpServletRequest request, HttpServletResponse response,
                                   User sessionUser) throws ServletException, IOException {
        Part filePart = request.getPart("profilePhoto");

        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("error", "Please select an image to upload.");
            reloadAndForward(request, response, sessionUser);
            return;
        }

        // Validate file type
        String contentType = filePart.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            request.setAttribute("error", "Only image files (JPG, PNG, GIF) are allowed.");
            reloadAndForward(request, response, sessionUser);
            return;
        }

        // Create upload directory if it doesn't exist
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Generate unique filename to avoid collisions
        String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String fileExtension = "";
        int dotIndex = originalFileName.lastIndexOf('.');
        if (dotIndex > 0) {
            fileExtension = originalFileName.substring(dotIndex);
        }
        String uniqueFileName = "user_" + sessionUser.getId() + "_" + UUID.randomUUID().toString().substring(0, 8) + fileExtension;

        // Save the file
        filePart.write(uploadPath + File.separator + uniqueFileName);

        // Save the relative path in the database
        String relativePath = UPLOAD_DIR + "/" + uniqueFileName;
        boolean updated = userDao.updateProfileImage(sessionUser.getId(), relativePath);

        if (updated) {
            User updatedUser = userDao.findByUsername(sessionUser.getUsername());
            SessionUtil.setAttribute(request, "user", updatedUser);
            request.setAttribute("success", "Profile photo updated successfully!");
            request.setAttribute("profileUser", updatedUser);

            List<CartItem> cartItems = cartDao.fetchAllCartItemsByUser(updatedUser.getId());
            request.setAttribute("cartItems", cartItems);
            List<Order> recentOrders = orderDao.findOrdersByUserId(updatedUser.getId());
            request.setAttribute("recentOrders", recentOrders);
            request.setAttribute("isAdmin", "admin@example.com".equals(updatedUser.getEmail()));
        } else {
            request.setAttribute("error", "Failed to save profile photo.");
            reloadAndForward(request, response, sessionUser);
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/profile.jsp")
                .forward(request, response);
    }

    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response,
                                     User sessionUser) throws ServletException, IOException {
        String newUsername = request.getParameter("username");
        String newEmail = request.getParameter("email");

        if (newUsername == null || newUsername.trim().isEmpty() ||
            newEmail == null || newEmail.trim().isEmpty()) {
            request.setAttribute("error", "Username and email cannot be empty.");
            reloadAndForward(request, response, sessionUser);
            return;
        }

        if (!newUsername.equalsIgnoreCase(sessionUser.getUsername())) {
            User existingUser = userDao.findByUsername(newUsername);
            if (existingUser != null) {
                request.setAttribute("error", "Username is already taken.");
                reloadAndForward(request, response, sessionUser);
                return;
            }
        }

        if (!newEmail.equalsIgnoreCase(sessionUser.getEmail())) {
            User existingUser = userDao.findByEmail(newEmail);
            if (existingUser != null) {
                request.setAttribute("error", "Email is already in use.");
                reloadAndForward(request, response, sessionUser);
                return;
            }
        }

        boolean updated = userDao.updateUser(sessionUser.getId(), newUsername.trim(), newEmail.trim());
        if (updated) {
            User updatedUser = userDao.findByUsername(newUsername.trim());
            SessionUtil.setAttribute(request, "user", updatedUser);
            request.setAttribute("success", "Profile updated successfully!");
            request.setAttribute("profileUser", updatedUser);

            List<CartItem> cartItems = cartDao.fetchAllCartItemsByUser(updatedUser.getId());
            request.setAttribute("cartItems", cartItems);
            List<Order> recentOrders = orderDao.findOrdersByUserId(updatedUser.getId());
            request.setAttribute("recentOrders", recentOrders);
            request.setAttribute("isAdmin", "admin@example.com".equals(updatedUser.getEmail()));
        } else {
            request.setAttribute("error", "Failed to update profile. Please try again.");
            reloadAndForward(request, response, sessionUser);
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/profile.jsp")
                .forward(request, response);
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response,
                                      User sessionUser) throws ServletException, IOException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        User freshUser = userDao.findByUsername(sessionUser.getUsername());

        if (freshUser == null) {
            request.setAttribute("error", "User not found.");
            reloadAndForward(request, response, sessionUser);
            return;
        }

        if (!PasswordUtil.checkPassword(currentPassword, freshUser.getPassword())) {
            request.setAttribute("error", "Current password is incorrect.");
            reloadAndForward(request, response, freshUser);
            return;
        }

        if (newPassword == null || newPassword.length() < 6) {
            request.setAttribute("error", "New password must be at least 6 characters.");
            reloadAndForward(request, response, freshUser);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New passwords do not match.");
            reloadAndForward(request, response, freshUser);
            return;
        }

        String hashedPassword = PasswordUtil.getHashPassword(newPassword);
        boolean updated = userDao.updatePassword(sessionUser.getId(), hashedPassword);

        if (updated) {
            User updatedUser = userDao.findByUsername(sessionUser.getUsername());
            SessionUtil.setAttribute(request, "user", updatedUser);
            request.setAttribute("success", "Password changed successfully!");
            request.setAttribute("profileUser", updatedUser);

            List<CartItem> cartItems = cartDao.fetchAllCartItemsByUser(updatedUser.getId());
            request.setAttribute("cartItems", cartItems);
            List<Order> recentOrders = orderDao.findOrdersByUserId(updatedUser.getId());
            request.setAttribute("recentOrders", recentOrders);
            request.setAttribute("isAdmin", "admin@example.com".equals(updatedUser.getEmail()));
        } else {
            request.setAttribute("error", "Failed to change password. Please try again.");
            reloadAndForward(request, response, freshUser);
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/profile.jsp")
                .forward(request, response);
    }

    private void reloadAndForward(HttpServletRequest request, HttpServletResponse response,
                                  User user) throws ServletException, IOException {
        request.setAttribute("profileUser", user);
        List<CartItem> cartItems = cartDao.fetchAllCartItemsByUser(user.getId());
        request.setAttribute("cartItems", cartItems);
        List<Order> recentOrders = orderDao.findOrdersByUserId(user.getId());
        request.setAttribute("recentOrders", recentOrders);
        request.setAttribute("isAdmin", "admin@example.com".equals(user.getEmail()));
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp")
                .forward(request, response);
    }
}
