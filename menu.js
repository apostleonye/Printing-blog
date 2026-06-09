document.addEventListener("DOMContentLoaded", () => {
    const mobileMenuBtn = document.getElementById("mobileMenuBtn");
    const navMenu = document.getElementById("navMenu");
    const themeToggle = document.getElementById("themeToggle");
    const docElement = document.documentElement;

    // ==========================================================================
    // 1. DYNAMIC THEME INGEST & RUNTIME PERSISTENCE LOGIC
    // ==========================================================================
    function initializeUserTheme() {
        const cachedTheme = localStorage.getItem("print_expertise_theme");
        
        // System preference listener check function fallback
        const systemPrefersDark = window.matchMedia("(prefers-color-scheme: dark)").matches;
        
        const runtimeTargetTheme = cachedTheme || (systemPrefersDark ? "dark" : "light");
        
        // Push configuration settings state into browser rendering tree
        docElement.setAttribute("data-theme", runtimeTargetTheme);
        updateToggleIconState(runtimeTargetTheme);
    }

    function updateToggleIconState(theme) {
        if (!themeToggle) return;
        themeToggle.textContent = theme === "dark" ? "☀️ Light Mode" : "🌙 Dark Mode";
        
        // Accessibility attribute state indicator hook
        themeToggle.setAttribute("aria-label", `Switch to ${theme === "dark" ? "light" : "dark"} orientation layout`);
    }

    if (themeToggle) {
        themeToggle.addEventListener("click", (e) => {
            e.stopPropagation(); // Shield mobile menu tray wrapper container nodes
            
            const activeTheme = docElement.getAttribute("data-theme");
            const structuralNextTheme = activeTheme === "dark" ? "light" : "dark";
            
            docElement.setAttribute("data-theme", structuralNextTheme);
            localStorage.setItem("print_expertise_theme", structuralNextTheme); // Retain selection across page changes
            updateToggleIconState(structuralNextTheme);
        });
    }

    // Run active theme resolution loop immediately
    initializeUserTheme();

    // ==========================================================================
    // 2. MOBILE MENU RESPONSIVE TRIGGER HANDLERS
    // ==========================================================================
    if (mobileMenuBtn && navMenu) {
        mobileMenuBtn.addEventListener("click", (e) => {
            e.preventDefault();
            e.stopPropagation();
            mobileMenuBtn.classList.toggle("active");
            navMenu.classList.toggle("active");
        });

        navMenu.querySelectorAll("a").forEach(link => {
            link.addEventListener("click", () => {
                mobileMenuBtn.classList.remove("active");
                navMenu.classList.remove("active");
            });
        });

        document.addEventListener("click", (e) => {
            if (!navMenu.contains(e.target) && !mobileMenuBtn.contains(e.target)) {
                mobileMenuBtn.classList.remove("active");
                navMenu.classList.remove("active");
            }
        });
    }
});
