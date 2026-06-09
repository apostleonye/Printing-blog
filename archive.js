document.addEventListener("DOMContentLoaded", () => {
    const searchInput = document.getElementById("blogSearch");
    const filterButtons = document.querySelectorAll(".filter-btn:not(#prevPage):not(#nextPage)");
    const cards = Array.from(document.querySelectorAll(".blog-card"));
    
    const prevBtn = document.getElementById("prevPage");
    const nextBtn = document.getElementById("nextPage");
    const pageIndicator = document.getElementById("pageIndicator");

    let currentPage = 1;
    const itemsPerPage = 4;
    let filteredCards = [...cards];

    // ==========================================================================
    // A. INTERSECTION OBSERVER LAZY-LOADING ROUTINE
    // ==========================================================================
    function initializeLazyLoading() {
        // Enforce native fallback if script layer execution is restricted or unsupported
        if (!('IntersectionObserver' in window)) {
            cards.forEach(card => {
                const img = card.querySelector('.card-img');
                if (img && img.dataset.src) img.src = img.dataset.src;
            });
            return;
        }

        const imageObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const card = entry.target;
                    const img = card.querySelector('.card-img');
                    
                    if (img && img.dataset.src) {
                        img.src = img.dataset.src; // Promote placeholder data string to actual source url
                        img.removeAttribute('data-src');
                    }
                    observer.unobserve(card); // Strip observer instance once download triggers
                }
            });
        }, {
            root: null,
            rootMargin: "0px 0px 200px 0px" // Trigger loading 200px before element hits viewport boundaries
        });

        cards.forEach(card => imageObserver.observe(card));
    }

    // ==========================================================================
    // B. FILTERING & MULTI-PAGE VIEWPORT RENDERING
    // ==========================================================================
    function filterAndPaginate() {
        const searchTerm = searchInput.value.toLowerCase().trim();
        const activeFilter = document.querySelector(".filter-btn.active").getAttribute("data-filter");

        filteredCards = cards.filter(card => {
            const category = card.getAttribute("data-category");
            const title = card.querySelector("h2").textContent.toLowerCase();
            const description = card.querySelector("p").textContent.toLowerCase();
            
            const matchesCategory = (activeFilter === "all" || category === activeFilter);
            const matchesSearch = (title.includes(searchTerm) || description.includes(searchTerm));

            return matchesCategory && matchesSearch;
        });

        const totalPages = Math.ceil(filteredCards.length / itemsPerPage) || 1;
        if (currentPage > totalPages) currentPage = totalPages;
        if (currentPage < 1) currentPage = 1;

        const startIndex = (currentPage - 1) * itemsPerPage;
        const endIndex = startIndex + itemsPerPage;

        cards.forEach(card => card.style.display = "none");
        
        filteredCards.slice(startIndex, endIndex).forEach(card => {
            card.style.display = "flex";
        });

        pageIndicator.textContent = `Page ${currentPage} of ${totalPages}`;
        prevBtn.disabled = (currentPage === 1);
        nextBtn.disabled = (currentPage === totalPages);
        
        prevBtn.style.opacity = prevBtn.disabled ? "0.4" : "1";
        nextBtn.style.opacity = nextBtn.disabled ? "0.4" : "1";
    }

    // Event Wireups
    searchInput.addEventListener("input", () => { currentPage = 1; filterAndPaginate(); });
    
    filterButtons.forEach(btn => {
        btn.addEventListener("click", (e) => {
            filterButtons.forEach(b => b.classList.remove("active"));
            e.target.classList.add("active");
            currentPage = 1;
            filterAndPaginate();
        });
    });

    prevBtn.addEventListener("click", () => { if (currentPage > 1) { currentPage--; filterAndPaginate(); } });
    nextBtn.addEventListener("click", () => { const totalPages = Math.ceil(filteredCards.length / itemsPerPage); if (currentPage < totalPages) { currentPage++; filterAndPaginate(); } });

    // Bootstrap execution steps
    filterAndPaginate();
    initializeLazyLoading();
});
