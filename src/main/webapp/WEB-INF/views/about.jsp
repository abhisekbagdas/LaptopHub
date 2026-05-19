<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>About</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/about.css"/>
</head>
<body>
<%@ include file="/WEB-INF/views/includes/navbar.jsp" %>
<!-- HERO -->
<section class="hero">
    <div class="hero-left">
        <p class="hero-eyebrow">Our Story</p>
        <h1>Powering <em>Dreams</em>,<br>One Laptop at a Time</h1>
        <p>Since 2014, LaptopVault has been the trusted destination for professionals, students, and creatives who
            demand the very best from their machines.</p>
        <div class="hero-stats">
            <div class="hero-stat"><strong>120K+</strong><span>Happy Customers</span></div>
            <div class="hero-stat"><strong>500+</strong><span>Models in Stock</span></div>
            <div class="hero-stat"><strong>10 Yrs</strong><span>Of Excellence</span></div>
        </div>
    </div>
    <div class="hero-right">
        <div class="hero-visual">
            <svg class="laptop-illustration" viewBox="0 0 420 320" fill="none" xmlns="http://www.w3.org/2000/svg">
                <rect x="60" y="40" width="300" height="200" rx="12" fill="#1a1a1a" stroke="#333" stroke-width="2"/>
                <rect x="75" y="55" width="270" height="170" rx="6" fill="#0a0a0a"/>
                <rect x="80" y="60" width="260" height="160" rx="4" fill="#111"/>
                <!-- Screen content simulation -->
                <rect x="95" y="75" width="230" height="12" rx="3" fill="#2a2a2a"/>
                <rect x="95" y="95" width="180" height="8" rx="2" fill="#222"/>
                <rect x="95" y="110" width="200" height="8" rx="2" fill="#222"/>
                <rect x="95" y="125" width="150" height="8" rx="2" fill="#222"/>
                <rect x="95" y="148" width="100" height="36" rx="6" fill="#c94c2e"/>
                <rect x="210" y="148" width="115" height="36" rx="6" fill="#1e1e1e" stroke="#333" stroke-width="1"/>
                <!-- Base -->
                <rect x="30" y="240" width="360" height="22" rx="6" fill="#1a1a1a"/>
                <rect x="150" y="238" width="120" height="4" rx="2" fill="#111"/>
                <!-- Hinge detail -->
                <rect x="55" y="236" width="310" height="5" rx="2" fill="#222"/>
            </svg>
            <div class="floating-badge badge-1"><span class="icon">⭐</span> 4.9 Rated Store</div>
            <div class="floating-badge badge-2"><span class="icon">🚚</span> Free Next-Day Shipping</div>
        </div>
    </div>
</section>

<!-- STORY -->
<section class="section story">
    <div class="story-grid">
        <div class="story-text">
            <p class="section-label">How It Started</p>
            <h2 class="section-title">Born from a Frustration, Built for You</h2>
            <p>It was 2014 when our founder, Arjun Mehta, couldn't find a reliable, honest laptop retailer. Big-box
                stores pushed overpriced models he didn't need. Online marketplaces were flooded with dubious
                listings.</p>
            <p>So he started LaptopVault - a curated online store focused on transparency, expert advice, and machines
                that truly match each buyer's needs. No fluff, no upsells, just the right laptop at the right price.</p>
            <p>Today, we're a team of 40+ tech enthusiasts shipping laptops to customers across 28 countries, with the
                same philosophy we started with: <em>honest, human-first tech retail.</em></p>
        </div>
        <div class="story-image-wrap">
            <div class="story-img-box">
                <svg viewBox="0 0 300 220" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="150" cy="110" r="80" fill="#c94c2e" opacity="0.12"/>
                    <rect x="70" y="60" width="160" height="110" rx="8" fill="#2d2d2d" stroke="#444"
                          stroke-width="1.5"/>
                    <rect x="80" y="70" width="140" height="90" rx="4" fill="#1a1a1a"/>
                    <rect x="90" y="82" width="120" height="8" rx="2" fill="#444"/>
                    <rect x="90" y="98" width="90" height="6" rx="2" fill="#333"/>
                    <rect x="90" y="110" width="110" height="6" rx="2" fill="#333"/>
                    <rect x="60" y="172" width="180" height="12" rx="4" fill="#2d2d2d"/>
                    <circle cx="225" cy="80" r="28" fill="#c94c2e" opacity="0.9"/>
                    <text x="225" y="86" fill="white" font-size="18" text-anchor="middle" font-family="serif">✓</text>
                </svg>
            </div>
            <div class="story-tag">Since 2014 <span>A decade of trust</span></div>
        </div>
    </div>
</section>

<!-- VALUES -->
<section class="section">
    <div class="values">
        <p class="section-label">What Drives Us</p>
        <h2 class="section-title">Our Core Values</h2>
        <p class="section-subtitle">Every decision we make comes back to three principles that have guided us since day
            one.</p>
        <div class="values-grid">
            <div class="value-card">
                <div class="value-icon">
                    <svg viewBox="0 0 24 24">
                        <path d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"/>
                    </svg>
                </div>
                <h3>Radical Transparency</h3>
                <p>No hidden fees, no inflated specs, no paid recommendations. We tell you what you need to hear, not
                    what sells the most margin.</p>
            </div>
            <div class="value-card">
                <div class="value-icon">
                    <svg viewBox="0 0 24 24">
                        <path d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0"/>
                    </svg>
                </div>
                <h3>Expert Guidance</h3>
                <p>Our team of certified tech advisors help you find the perfect match - whether you're a gamer,
                    designer, student, or business professional.</p>
            </div>
            <div class="value-card">
                <div class="value-icon">
                    <svg viewBox="0 0 24 24">
                        <path d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/>
                    </svg>
                </div>
                <h3>Customer First, Always</h3>
                <p>From a 30-day no-questions-asked return policy to lifetime tech support, we're with you long after
                    checkout.</p>
            </div>
        </div>
    </div>
</section>

<!-- TEAM -->
<section class="section team">
    <div style="max-width: 1200px; margin: 0 auto;">
        <p class="section-label">The People Behind The Screen</p>
        <h2 class="section-title">Meet Our Dev. Team</h2>
        <div class="team-grid">
            <div class="team-card">
                <div class="avatar M1"><img src="${pageContext.request.contextPath}/static/images/dev/Abhisek.jpg"
                                            style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover;"
                                            alt="Abhisek Bagdas  "></div>
                <h4>Abhisek Bagdas</h4>
                <p>Backend Developer</p>
            </div>
            <div class="team-card">
                <div class="avatar M2"><img src="${pageContext.request.contextPath}/static/images/dev/Lucky.jpeg"
                                            style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover;">
                </div>
                <h4>Lucky Gurung</h4>
                <p>Database Developer</p>
            </div>
            <div class="team-card">
                <div class="avatar M3"><img src="${pageContext.request.contextPath}/static/images/dev/Oasis.jpeg"
                                            style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover;">
                </div>
                <h4>Oasis Adhikari</h4>
                <p>Marketing Expert</p>
            </div>
            <div class="team-card">
                <div class="avatar M4"><img src="${pageContext.request.contextPath}/static/images/dev/Rahul.jpeg"
                                            style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover;">
                </div>
                <h4>Rahul Rasaily</h4>
                <p>Lead Tech Advisor</p>
            </div>
            <div class="team-card">
                <div class="avatar M5"><img src="${pageContext.request.contextPath}/static/images/dev/Shakti.jpeg"
                                            style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover;">
                </div>
                <h4>Shakti Sedai</h4>
                <p>Customer Experience</p>
            </div>
            <div class="team-card">
                <div class="avatar M6"><img src="${pageContext.request.contextPath}/static/images/dev/Sobim.jpeg"
                                            style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover;">
                </div>
                <h4>Sobim Shrestha</h4>
                <p>Frontend Developer and Designer</p>
            </div>
        </div>
    </div>
</section>

<!-- TIMELINE -->
<section class="section timeline-section">
    <div style="max-width: 1100px; margin: 0 auto;">
        <p class="section-label">Our Journey</p>
        <h2 class="section-title">A Decade of Milestones</h2>
        <div class="timeline">
            <div class="tl-item">
                <div class="tl-dot">14</div>
                <div class="tl-content">
                    <h4>Founded in 2014</h4>
                    <p>Arjun Mehta launches LaptopVault from a small home office in Bangalore with just 12 laptop
                        models.</p>
                </div>
            </div>
            <div class="tl-item">
                <div class="tl-dot">16</div>
                <div class="tl-content">
                    <h4>10,000 Customers Milestone</h4>
                    <p>Expanded to a dedicated warehouse and hired the first team of 8 tech advisors.</p>
                </div>
            </div>
            <div class="tl-item">
                <div class="tl-dot">19</div>
                <div class="tl-content">
                    <h4>International Expansion</h4>
                    <p>Launched international shipping to 15 countries and introduced the Price-Match Guarantee.</p>
                </div>
            </div>
            <div class="tl-item">
                <div class="tl-dot">22</div>
                <div class="tl-content">
                    <h4>Certified Refurbished Program</h4>
                    <p>Introduced our eco-conscious Certified Refurbished line, saving over 8,000 laptops from
                        landfills.</p>
                </div>
            </div>
            <div class="tl-item">
                <div class="tl-dot">24</div>
                <div class="tl-content">
                    <h4>10 Years Strong</h4>
                    <p>Celebrated a decade with 120,000+ customers, 40 team members, and a brand new HQ in Pokhara.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CTA -->
<section class="cta-banner">
    <h2>Ready to Find Your Perfect Laptop?</h2>
    <p>Our experts are standing by to help you make the right choice, every time.</p>
    <a href="${pageContext.request.contextPath}/products" class="btn-white">Shop Now</a>
    <a href="${pageContext.request.contextPath}/contact" class="btn-outline">Talk to an Expert</a>
</section>

<!-- FOOTER -->
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>
