CREATE TABLE articles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    slug VARCHAR(100) UNIQUE NOT NULL, 
    category VARCHAR(50) NOT NULL,     
    title VARCHAR(255) NOT NULL,
    hero_image VARCHAR(255) NOT NULL,  
    image_caption VARCHAR(255),
    body_text TEXT NOT NULL,           
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE quote_requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(150) NOT NULL,
    corporate_email VARCHAR(150) NOT NULL,
    service_matrix VARCHAR(50) NOT NULL,  
    paper_gsm INT NOT NULL,               
    run_quantity INT NOT NULL,
    customization_details TEXT,
    estimated_cost DECIMAL(10, 2),       
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE uploaded_blueprints (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quote_request_id INT,
    file_name VARCHAR(255) NOT NULL,
    file_path VARCHAR(255) NOT NULL,      
    file_size_mb DECIMAL(5, 2),
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (quote_request_id) REFERENCES quote_requests(id) ON DELETE CASCADE
);


-- Create the secure administrators repository table mapping
CREATE TABLE IF NOT EXISTS admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Seed your database with 'print_admin' profile
-- The hash string below corresponds to the password 'secure_print_2026' via password_hash()
INSERT INTO admins (username, password_hash) VALUES 
('print_admin', '$2y$10$fVzB8n6Dclx0tU8KjB6U8.UHezYkI7x.GbeXbUaFidg/O.3i1f7bC')
ON DUPLICATE KEY UPDATE username=username;



-- Insert the 6 technical print production blog articles
INSERT INTO articles (slug, category, title, hero_image, image_caption, body_text) VALUES
(
    'souvenirs', 
    'souvenirs', 
    'How to Select Premium Executive Gifts That Keep Your Brand Top-of-Mind', 
    'https://picsum.photos', 
    'Figure 1.1: Precision debossing pass executed on 400gsm genuine core leather journal bindings.', 
    '<p>In high-stakes corporate networking events, standard handouts like generic branded plastic pens are immediately discarded. To leave a permanent corporate impression, company executives must source meaningful souvenirs that harmonize utility with your brand identity.</p>\r\n<h2>Focus on Utility and Retention</h2>\r\n<p>Premium souvenirs like executive travel organizers, heavy-gauge custom metal tech hubs, or laser-engraved bamboo journals boast high daily retention rates. The longer a client retains your gift item, the higher your long-term organic brand equity becomes.</p>\r\n<h2>Production Capabilities</h2>\r\n<p>Our production facilities utilize modern industrial fiber-laser engraving arrays and structural debossing presses. This allows us to apply crisp corporate logomarks to dense technical textiles, genuine leather, and anodized aluminum casings with zero bleeding or scaling errors.</p>'
),
(
    'packaging', 
    'packaging', 
    'Sizing and Material Guide: Choosing Between Rigid Boxes and Folding Cartons', 
    'https://picsum.photos', 
    'Figure 1.2: Quality control testing of double-walled corrugated shipping structures.', 
    '<p>Selecting the proper physical board container architecture directly dictates your structural damage rates, customer unboxing experiences, and shipping volume costs.</p>\r\n<h2>Rigid Structural Set-Up Boxes</h2>\r\n<p>Rigid boxes are engineered using thick, non-collapsible chipboard blanks wrapped in premium art paper. These are optimized for high-end luxury products, complex corporate presentation packages, or heavy electronic components requiring high structural defense.</p>\r\n<h2>Folding Cartons</h2>\r\n<p>Folding cartons are manufactured from flat sheets of SBS (Solid Bleached Sulfate) paperboard. They ship entirely flat to minimize your warehousing storage footprints and feature quick-assembly locking points for high-volume automated fulfillment lines.</p>'
),
(
    'branding', 
    'branding', 
    'Why Your Brand Colors Look Different on Digital Screens vs. Coated Paper', 
    'https://picsum.photos', 
    'Figure 1.3: Spectrophotometer monitoring calibration pass comparing screen RGB variances to liquid spot tones.', 
    '<p>A frequent error for corporate brand managers is expecting digital RGB screen colors to match physical ink pigments exactly. Preserving visual brand consistency requires basic knowledge of substrate absorption profiles.</p>\r\n<h2>The Substrate Reflection Problem</h2>\r\n<p>Digital devices projects colored light using light-emitting diodes (RGB), whereas physical paper absorbs and reflects ambient illumination via cyan, magenta, yellow, and black pigments (CMYK). Uncoated paper textures soak up ink aggressively, causing colors to drift muted or dark compared to glossy coated surfaces.</p>\r\n<h2>Deploying Certified Spot Tones</h2>\r\n<p>To eliminate output errors, always specify target Pantone Matching System (PMS) reference values inside your master files. Our facility checks every production pass using digital spectrophotometers to guarantee precision tolerances across all materials.</p>'
),
(
    'brochures', 
    'brochures', 
    'Choosing the Right Paper Weight (GSM) for Corporate Profiles vs. Handout Flyers', 
    'https://picsum.photos', 
    'Figure 1.4: Cross-section profiling of wire-o binding setups on heavy corporate portfolios.', 
    '<p>The tactile weight of your corporate catalog sets immediate assumptions about your corporate scale before a prospect reads a single sentence.</p>\r\n<h2>Understanding Paper Weights (Grams per Square Meter)</h2>\r\n<ul>\r\n<li><strong>80 - 120 GSM:</strong> Typical lightweight paper stocks. Best for the inner catalog pages of high-sheet-count annual financial reports.</li>\r\n<li><strong>150 - 200 GSM:</strong> Medium heavy sheet profile. Ideal for folding tri-fold sales brochures and corporate menus.</li>\r\n<li><strong>250 - 350+ GSM:</strong> Thick, high-caliper board cover stock. Standard requirement for high-end corporate profiles, business cards, and presentation folders.</li>\r\n</ul>'
),
(
    'tech', 
    'tech', 
    'Offset vs. Digital Printing: Which Method Offers the Best ROI for Your Print Run?', 
    'https://picsum.photos', 
    'Figure 1.5: Automated line optimization matrix configuring industrial digital web press units.', 
    '<p>Understanding where industrial digital production methods give way to high-volume offset ink matrices saves your firm substantial procurement capital.</p>\r\n<h2>The Economic Crossover Boundaries</h2>\r\n<p>Digital printing bypasses traditional aluminum master plate setups entirely, which eliminates early engineering costs. However, offset presses run at rapid speeds with lower bulk unit consumable expenses, making massive production quantities much more cost-effective.</p>'
),
(
    'eco_packaging', 
    'packaging', 
    'The Brand Manager\'s Guide to Sustainable Packaging and Soy Inks', 
    'https://picsum.photos', 
    'Figure 1.6: Tensile structural strength examination of unbleached post-consumer kraft board stocks.', 
    '<p>Modern enterprises face strict demands to eliminate plastic materials from consumer touchpoints. Transitioning your structural packaging workflows to circular paper solutions immediately satisfies regulatory expectations without lowering product aesthetics.</p>\r\n<h2>The Structural Advantages of Recycled Kraft</h2>\r\n<p>Unbleached post-consumer kraft fibers maintain high tensile strength while projecting organic corporate responsibility. When matched with structural scoring patterns, kraft paper creates rugged, protective presentation formats across hardware, cosmetic, or consumer product sectors.</p>\r\n<h2>Soy-Based Organic Inks vs. Petroleum Standards</h2>\r\n<p>Traditional printing inks release volatile organic compounds (VOCs) during industrial drying loops. Soy inks rely entirely on natural agricultural oils. This method yields exceptionally vibrant, high-transparency color rendering while allowing the base fibers to disintegrate smoothly inside municipal recycling operations.</p>'
);
