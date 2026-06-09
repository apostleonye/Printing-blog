// AJAX Article Loader Script
document.addEventListener('DOMContentLoaded', function() {
    // Get article ID from URL parameters
    const urlParams = new URLSearchParams(window.location.search);
    const articleId = urlParams.get('id');
    
    // If article ID exists, load it
    if (articleId) {
        loadArticle(articleId);
    } else {
        showError('No article ID provided. Please return to the blog and select an article.');
    }
    
    // Copy link button functionality
    const copyLinkBtn = document.getElementById('copyLinkBtn');
    if (copyLinkBtn) {
        copyLinkBtn.addEventListener('click', function() {
            const url = window.location.href;
            navigator.clipboard.writeText(url).then(function() {
                const alert = document.getElementById('copyAlert');
                alert.style.opacity = '1';
                setTimeout(() => {
                    alert.style.opacity = '0';
                }, 2000);
            });
        });
    }
});

/**
 * Fetch and load article content via AJAX
 * @param {string} articleId - The unique article identifier
 */
function loadArticle(articleId) {
    // Show loading state
    showLoadingState();
    
    // Fetch from PHP endpoint
    fetch(`get-article.php?id=${encodeURIComponent(articleId)}`)
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            if (data.error) {
                showError(data.error);
            } else {
                populateArticleContent(data);
            }
        })
        .catch(error => {
            console.error('Error loading article:', error);
            showError('Failed to load article. Please try again later.');
        });
}

/**
 * Populate the page with article data
 * @param {object} article - Article data object from database
 */
function populateArticleContent(article) {
    // Update document title
    document.title = `${article.title} | PrintExpertise`;
    
    // Populate article badge (category)
    const badgeElement = document.getElementById('articleBadge');
    if (badgeElement) {
        badgeElement.textContent = article.category.replace(/([A-Z])/g, ' $1').trim();
    }
    
    // Populate article title
    const titleElement = document.getElementById('articleTitle');
    if (titleElement) {
        titleElement.textContent = article.title;
    }
    
    // Populate article metadata (date and author)
    const metaElement = document.getElementById('articleMeta');
    if (metaElement) {
        const pubDate = new Date(article.published_date);
        const formattedDate = pubDate.toLocaleDateString('en-US', { 
            year: 'numeric', 
            month: 'long', 
            day: 'numeric' 
        });
        metaElement.innerHTML = `<strong>Published:</strong> ${formattedDate} | <strong>Category:</strong> ${article.category}`;
        if (article.author) {
            metaElement.innerHTML += ` | <strong>Author:</strong> ${article.author}`;
        }
    }
    
    // Populate hero image
    const heroImageElement = document.getElementById('articleHeroImage');
    if (heroImageElement && article.hero_image_url) {
        heroImageElement.src = article.hero_image_url;
        heroImageElement.alt = article.title;
    }
    
    // Populate image caption
    const captionElement = document.getElementById('imageCaption');
    if (captionElement) {
        captionElement.textContent = article.image_caption || 'Production specification overview';
    }
    
    // Populate article body
    const bodyElement = document.getElementById('articleBody');
    if (bodyElement) {
        // Parse the article body - it may contain HTML formatting
        bodyElement.innerHTML = article.article_body;
    }
    
    // Populate related articles sidebar
    populateRelatedArticles(article.related_articles);
    
    // Update meta description
    updateMetaDescription(article.meta_description || article.article_body.substring(0, 150));
}

/**
 * Populate the related articles sidebar
 * @param {array} relatedArticles - Array of related article objects
 */
function populateRelatedArticles(relatedArticles) {
    const container = document.getElementById('relatedPostsContainer');
    
    if (!container || !relatedArticles || relatedArticles.length === 0) {
        if (container) {
            container.innerHTML = '<p style="color: #718096;">No related articles found.</p>';
        }
        return;
    }
    
    let htmlContent = '';
    
    relatedArticles.forEach(article => {
        const pubDate = new Date(article.published_date);
        const formattedDate = pubDate.toLocaleDateString('en-US', { 
            year: 'numeric', 
            month: 'short', 
            day: 'numeric' 
        });
        
        htmlContent += `
            <div class="related-post-card" style="
                padding: 12px;
                border-radius: 8px;
                border: 1px solid #e2e8f0;
                transition: all 0.3s ease;
                cursor: pointer;
                text-decoration: none;
                color: inherit;
                display: flex;
                flex-direction: column;
                gap: 8px;
            " onclick="window.location.href='article-detail.html?id=${article.article_id}'">
                <img src="${article.hero_image_url}" alt="${article.title}" style="
                    width: 100%;
                    height: 100px;
                    object-fit: cover;
                    border-radius: 6px;
                ">
                <h4 style="margin: 0; font-size: 14px; font-weight: 600; line-height: 1.3;">
                    ${article.title}
                </h4>
                <span style="font-size: 12px; color: #a0aec0;">
                    ${formattedDate}
                </span>
            </div>
        `;
    });
    
    container.innerHTML = htmlContent;
}

/**
 * Show loading state with skeleton placeholders
 */
function showLoadingState() {
    const titleElement = document.getElementById('articleTitle');
    const bodyElement = document.getElementById('articleBody');
    const metaElement = document.getElementById('articleMeta');
    
    if (titleElement) titleElement.innerHTML = '<div class="skeleton-loader" style="height: 40px; background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%); background-size: 200% 100%; animation: shimmer 2s infinite; border-radius: 4px;"></div>';
    
    if (metaElement) metaElement.innerHTML = '<div class="skeleton-loader" style="height: 16px; background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%); background-size: 200% 100%; animation: shimmer 2s infinite; border-radius: 4px; width: 60%;"></div>';
    
    if (bodyElement) bodyElement.innerHTML = '<div class="skeleton-loader" style="height: 200px; background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%); background-size: 200% 100%; animation: shimmer 2s infinite; border-radius: 4px;"></div>';
    
    // Add keyframes for shimmer animation
    const style = document.createElement('style');
    style.textContent = `
        @keyframes shimmer {
            0% { background-position: 200% 0; }
            100% { background-position: -200% 0; }
        }
    `;
    document.head.appendChild(style);
}

/**
 * Display error message
 * @param {string} message - Error message to display
 */
function showError(message) {
    const bodyElement = document.getElementById('articleBody');
    
    if (bodyElement) {
        bodyElement.innerHTML = `
            <div style="
                background-color: #fee;
                border: 1px solid #f88;
                border-radius: 8px;
                padding: 20px;
                text-align: center;
                color: #c33;
            ">
                <h3>Error Loading Article</h3>
                <p>${message}</p>
                <a href="index.html" class="cta-btn" style="display: inline-block; margin-top: 16px;">
                    Return to Blog
                </a>
            </div>
        `;
    }
    
    // Also log to console for debugging
    console.error('Article Load Error:', message);
}

/**
 * Update meta description tag
 * @param {string} description - Meta description text
 */
function updateMetaDescription(description) {
    let metaDesc = document.querySelector('meta[name="description"]');
    
    if (!metaDesc) {
        metaDesc = document.createElement('meta');
        metaDesc.name = 'description';
        document.head.appendChild(metaDesc);
    }
    
    metaDesc.content = description.substring(0, 160);
}
