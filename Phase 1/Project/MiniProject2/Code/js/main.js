
function login() {
  const role = document.getElementById('role-select').value;
  localStorage.setItem("role", role);
  window.location.href = role === "admin" ? "admin-home.html" : "user-home.html";
}

function logout() {
  localStorage.removeItem("role");
  localStorage.removeItem("username");
  localStorage.removeItem("cart");
  window.location.href = "login.html";
}

function checkLogin() {
  const role = localStorage.getItem("role");
  if (!role) {
    alert("Please login first.");
    window.location.href = "login.html";
  }
}

function loadHeader() { 
  fetch('components/header.html')
    .then(res => res.text())
    .then(data => {
      document.getElementById('header-placeholder').innerHTML = data;

      requestAnimationFrame(() => {
        const role = localStorage.getItem("role");
        const username = localStorage.getItem("username") || 'Guest';

        const homeLink = document.getElementById("home-link");
        console.log(homeLink);
        if (homeLink) {
          homeLink.href = role === "admin" ? "admin-home.html" : "user-home.html";
        }

        const cartNav = document.getElementById("cart-nav-item");
        console.log(cartNav);
        if (role === "admin" && cartNav) {
          cartNav.style.display = "none";
        }

        const welcome = document.getElementById("welcome-message");
        if (welcome) {
          welcome.textContent = `Welcome, ${username}`;
        }

        const addProductNav = document.getElementById("add-product-nav");
        if (role === "admin" && addProductNav) {
          addProductNav.classList.remove("d-none");
        }
            updateCartCount();
      });
    });
}

function updateCartCount() {
  const cart = JSON.parse(localStorage.getItem("cart")) || [];
  const cartCountEl = document.getElementById("cart-count");
  console.log("cartCountElement",cartCountEl);
  if (cartCountEl) {
    cartCountEl.textContent = cart.length;
  }
}




