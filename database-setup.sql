-- Create printing blog database
CREATE DATABASE IF NOT EXISTS printing_blog;
USE printing_blog;

-- Create articles table
CREATE TABLE IF NOT EXISTS articles (
    article_id VARCHAR(50) PRIMARY KEY NOT NULL,
    title VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    published_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    author VARCHAR(100),
    hero_image_url VARCHAR(500),
    image_caption TEXT,
    article_body LONGTEXT NOT NULL,
    meta_description VARCHAR(160),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_category (category),
    INDEX idx_published_date (published_date)
);

-- Insert sample articles based on index.html content
INSERT INTO articles (article_id, title, category, published_date, author, hero_image_url, image_caption, article_body, meta_description) VALUES
(
    'souvenirs',
    'How to Select Premium Executive Gifts That Keep Your Brand Top-of-Mind',
    'Event Souvenirs',
    '2026-06-08',
    'PrintExpertise Team',
    'https://picsum.photos/800/400?random=1',
    'Premium corporate event leather diaries and engraved pens as executive gifts',
    '<p>Discover strategies for sourcing functional, high-retention corporate gifts that elevate your brand image during elite corporate events.</p>
    <h2>The Strategic Importance of Executive Gifts</h2>
    <p>Corporate gifts serve as tangible reminders of business relationships and partnerships. Unlike digital communications, physical gifts create lasting impressions and demonstrate genuine investment in professional relationships.</p>
    <h2>Selection Criteria for Premium Souvenirs</h2>
    <ul>
        <li><strong>Utility:</strong> Choose items that recipients will actually use in their professional lives</li>
        <li><strong>Quality:</strong> Premium materials signal brand quality and professionalism</li>
        <li><strong>Customization:</strong> Personalization through engraving or custom printing amplifies brand recall</li>
        <li><strong>Sustainability:</strong> Eco-friendly options align with modern corporate values</li>
    </ul>
    <h2>Production Considerations</h2>
    <p>When working with printing partners, ensure clear specifications for engraving depth, material finishes, and packaging presentations. Lead times for premium items typically range from 4-8 weeks for bulk orders.</p>',
    'Learn how to select premium executive gifts for corporate events that enhance brand recall and build lasting professional relationships.'
),
(
    'packaging',
    'Sizing and Material Guide: Choosing Between Rigid Boxes and Folding Cartons',
    'Packaging',
    '2026-06-05',
    'PrintExpertise Team',
    'https://picsum.photos/800/400?random=2',
    'Custom rigid structural cosmetics boxes lined up on printing floor',
    '<p>An in-depth industrial breakdown of packaging materials, structural engineering, and box layouts to minimize shipping overheads.</p>
    <h2>Rigid Boxes vs. Folding Cartons</h2>
    <p>The choice between rigid and folding cartons depends on product positioning, shipping costs, and unboxing experience priorities.</p>
    <h3>Rigid Box Advantages</h3>
    <ul>
        <li>Premium perceived value for luxury products</li>
        <li>Superior product protection during transit</li>
        <li>Enhanced unboxing experience for brand differentiation</li>
        <li>Reusable storage appeal increases brand touchpoints</li>
    </ul>
    <h3>Folding Carton Advantages</h3>
    <ul>
        <li>Significantly reduced material and shipping costs</li>
        <li>Faster production and fulfillment cycles</li>
        <li>Optimal for high-volume mass market products</li>
        <li>Better environmental footprint per unit</li>
    </ul>
    <h2>Material Selection Factors</h2>
    <p><strong>Paper Weight (GSM):</strong> Ranges from 200-400 GSM. Higher GSM provides better durability and perceived quality.</p>
    <p><strong>Coating Options:</strong> Gloss, matte, and soft-touch coatings affect aesthetics and tactile experience.</p>
    <p><strong>Structural Integrity:</strong> Die-cut precision and crease placement prevent damage and ensure consistent stack height.</p>',
    'Compare rigid boxes and folding cartons for your packaging needs. Learn material specifications, cost implications, and production best practices.'
),
(
    'branding',
    'Why Your Brand Colors Look Different on Digital Screens vs. Coated Paper',
    'Brand Identity',
    '2026-05-28',
    'PrintExpertise Team',
    'https://picsum.photos/800/400?random=3',
    'Pantone matching system swatches placed beside a digital display monitor',
    '<p>Learn how to preserve critical Pantone corporate colors across mixed print media types through certified ink management systems.</p>
    <h2>Color Space Fundamentals</h2>
    <p>Digital displays use RGB (Red, Green, Blue) color space, while print uses CMYK (Cyan, Magenta, Yellow, Black). This fundamental difference creates inherent color variation.</p>
    <h2>RGB vs. CMYK Conversion</h2>
    <p>RGB color space produces brighter, more saturated colors because light-based displays are additive. Print media is subtractive - ink absorbs light, resulting in naturally less vivid colors.</p>
    <h2>Pantone Matching System (PMS)</h2>
    <p>Pantone numbers provide a universal color standard across print media. Specify Pantone colors in contracts with printing vendors to ensure consistency regardless of paper type.</p>
    <h2>Paper Surface Impact</h2>
    <ul>
        <li><strong>Glossy Paper:</strong> Reflects more light, colors appear more vibrant and saturated</li>
        <li><strong>Matte Paper:</strong> Absorbs light, colors appear more muted and sophisticated</li>
        <li><strong>Uncoated Paper:</strong> Shows ink absorption irregularities, may appear grainy</li>
    </ul>
    <h2>Maintaining Brand Color Consistency</h2>
    <p>Work with ISO 12647-2 certified printers who maintain color profiling standards. Request drawdowns before full production runs to approve final color appearance on your specific substrate.</p>',
    'Understand why brand colors appear different in print vs. digital. Learn how to maintain color consistency across Pantone specifications and paper types.'
),
(
    'brochures',
    'Choosing the Right Paper Weight (GSM) for Corporate Profiles vs. Handout Flyers',
    'Brochures & Collateral',
    '2026-05-15',
    'PrintExpertise Team',
    'https://picsum.photos/800/400?random=4',
    'Stack of high GSM glossy gate-fold corporate profile brochures',
    '<p>Demystifying technical paper stocks, tactile coatings, and folding systems to optimize your high-volume marketing collateral print spend.</p>
    <h2>Understanding Paper Weight (GSM)</h2>
    <p>GSM (grams per square meter) indicates paper density and thickness. Higher GSM values create more substantial, premium-feeling products.</p>
    <h2>GSM Recommendations by Use Case</h2>
    <table style="width: 100%; border-collapse: collapse; margin: 20px 0;">
        <thead>
            <tr style="background: #f5f5f5;">
                <th style="border: 1px solid #ddd; padding: 12px; text-align: left;">Use Case</th>
                <th style="border: 1px solid #ddd; padding: 12px; text-align: left;">GSM Range</th>
                <th style="border: 1px solid #ddd; padding: 12px; text-align: left;">Reason</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td style="border: 1px solid #ddd; padding: 12px;">Handout Flyers</td>
                <td style="border: 1px solid #ddd; padding: 12px;">100-150 GSM</td>
                <td style="border: 1px solid #ddd; padding: 12px;">Cost-effective for mass distribution</td>
            </tr>
            <tr>
                <td style="border: 1px solid #ddd; padding: 12px;">Standard Brochures</td>
                <td style="border: 1px solid #ddd; padding: 12px;">200-250 GSM</td>
                <td style="border: 1px solid #ddd; padding: 12px;">Balance of durability and cost</td>
            </tr>
            <tr>
                <td style="border: 1px solid #ddd; padding: 12px;">Premium Corporate Profiles</td>
                <td style="border: 1px solid #ddd; padding: 12px;">300-350 GSM</td>
                <td style="border: 1px solid #ddd; padding: 12px;">Premium feel justifies higher cost</td>
            </tr>
        </tbody>
    </table>
    <h2>Coating Considerations</h2>
    <p>Glossy coatings enhance color vibrancy and durability. Matte coatings provide professional appearance and reduce fingerprints. Soft-touch coatings create premium tactile experience.</p>
    <h2>Folding Specifications</h2>
    <p>Ensure printer uses appropriate crease settings for your GSM weight. Heavier papers (300+ GSM) may require speciality equipment to avoid cracking during folding.</p>',
    'Select optimal paper weight (GSM) for brochures and collateral. Comparison chart and coating guidance for cost-effective high-quality marketing materials.'
),
(
    'tech',
    'Offset vs. Digital Printing: Which Method Offers the Best ROI for Your Print Run?',
    'Production Tech',
    '2026-05-02',
    'PrintExpertise Team',
    'https://picsum.photos/800/400?random=5',
    'Massive commercial multi-unit Heidelberg offset printing press running at high speeds',
    '<p>Analyze the production thresholds, setup times, and exact cost crossover boundaries of digital presses vs. high-volume offset systems.</p>
    <h2>Cost Structure Fundamentals</h2>
    <p>Offset printing involves high fixed setup costs but lower per-unit costs. Digital printing has minimal setup costs but higher per-unit costs. The breakeven point depends on run volume.</p>
    <h2>Offset Printing Economics</h2>
    <ul>
        <li><strong>Setup Costs:</strong> $800-$2,500 per job (plates, color separation, registration)</li>
        <li><strong>Per-Unit Cost:</strong> $0.02-$0.10 per item (highly scalable)</li>
        <li><strong>Minimum Run:</strong> 1,000-5,000 units recommended</li>
        <li><strong>Lead Time:</strong> 5-10 business days</li>
    </ul>
    <h2>Digital Printing Economics</h2>
    <ul>
        <li><strong>Setup Costs:</strong> $50-$200 per job (minimal)</li>
        <li><strong>Per-Unit Cost:</strong> $0.08-$0.30 per item (volume discounts available)</li>
        <li><strong>Minimum Run:</strong> 100-500 units feasible</li>
        <li><strong>Lead Time:</strong> 2-3 business days</li>
    </ul>
    <h2>Breakeven Analysis</h2>
    <p>For standard business cards at typical pricing, digital becomes cost-competitive up to 2,500 units. For complex color brochures, offset breakeven often occurs at 5,000+ units.</p>
    <h2>Quality Considerations</h2>
    <p>Offset printing produces superior color consistency and handles specialty inks (metallics, fluorescent) better. Digital printing excels at variable data printing and short-run personalization.</p>
    <h2>Decision Matrix</h2>
    <p><strong>Choose Digital If:</strong> Run volume under 3,000 units, need rush turnaround, require personalization, or budget doesn''t support setup costs.</p>
    <p><strong>Choose Offset If:</strong> Run volume exceeds 5,000 units, need superior color consistency, using specialty inks, or cost per unit is critical metric.</p>',
    'Compare offset vs. digital printing ROI. Detailed cost analysis, breakeven calculations, and when to use each production method for maximum efficiency.'
),
(
    'eco_packaging',
    'The Brand Manager''s Guide to Sustainable Packaging and Soy Inks',
    'Packaging',
    '2026-04-22',
    'PrintExpertise Team',
    'https://picsum.photos/800/400?random=6',
    'Biodegradable eco-friendly brown kraft paper shopping bags with soy ink graphics',
    '<p>Uncover how modern biodegradable structural kraft paper options and plant-based soy inks can align your physical product logistics with corporate ESG targets.</p>
    <h2>Sustainable Packaging Drivers</h2>
    <p>Consumer preference for eco-friendly packaging has increased 45% in B2B supply chains. Aligning packaging with ESG commitments strengthens brand reputation and customer retention.</p>
    <h2>Kraft Paper Sustainability</h2>
    <ul>
        <li>Made from recycled fiber or sustainably harvested wood pulp</li>
        <li>100% recyclable and compostable</li>
        <li>Typically 20-30% less expensive than virgin fiber alternatives</li>
        <li>Natural appearance aligns with eco-conscious brand positioning</li>
    </ul>
    <h2>Soy Inks Environmental Benefits</h2>
    <p>Soy-based inks replace petroleum-derived inks, reducing carbon footprint by 25-40%. They produce richer colors, cure faster, and are easier to remove during paper recycling processes.</p>
    <h2>Implementation Strategy</h2>
    <p>Transition to sustainable packaging incrementally. Start with secondary packaging (mailing boxes, inserts) before converting primary product packaging. This reduces transition risk and allows supplier relationship building.</p>
    <h2>Certification Verification</h2>
    <p>Specify FSC (Forest Stewardship Council) or PEFC (Programme for the Endorsement of Forest Certification) certifications when sourcing kraft papers. Demand ISO 14001 environmental management system compliance from printing vendors.</p>
    <h2>Cost Impact Analysis</h2>
    <p>Sustainable materials typically add 5-15% to packaging costs, but premium positioning often justifies price increases. Calculate lifetime customer value impact—eco-conscious consumers have 3.2x higher lifetime value.</p>',
    'Implement sustainable packaging with kraft paper and soy inks. ESG alignment strategy, cost analysis, and certification guidance for eco-conscious brand positioning.'
);
