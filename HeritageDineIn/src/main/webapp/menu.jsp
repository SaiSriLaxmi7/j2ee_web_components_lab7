<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tags.tld" prefix="custom" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Restaurant Menu</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="styles.css"> <!-- External CSS Link -->
</head>
<body>

    <h1>Restaurant Menu</h1>
    <div class="menu-container">
        <p id="loading-message">Loading menu items...</p>
        <div id="menu-content"></div>
    </div>

    <script>
        $(document).ready(function () {
            $.ajax({
                url: "menu", // Calls MenuServlet
                method: "GET",
                dataType: "json",
                success: function (data) {
                    $("#loading-message").hide();
                    let menuContent = "";
                    let categories = {};

                    // Group menu items by category
                    data.forEach(function(item) {
                        let category = item.categoryName || "Uncategorized";  // Default to "Uncategorized" if no category
                        if (!categories[category]) {
                            categories[category] = [];
                        }
                        categories[category].push(item);
                    });

                    // Debugging: Check the grouped categories in the console
                    console.log(categories);

                    // Generate HTML for categories and their items
                    for (let category in categories) {
                        menuContent += "<h2>" + category + "</h2>";  // Add category heading

                        categories[category].forEach(function(item) {
                            // Correctly parse float in JavaScript using string concatenation (no EL)
                            menuContent += `
                                <div class="menu-item">
                                    <strong>` + item.name + `</strong> - <span class="price">$` + parseFloat(item.price).toFixed(2) + `</span><br>
                                    <em>` + (item.description || "No description available") + `</em>
                                </div>
                            `;
                        });
                    }

                    // Update the content in the HTML
                    $("#menu-content").html(menuContent);
                },
                error: function () {
                    $("#loading-message").hide();
                    $("#menu-content").html("<p class='error'>Error loading menu. Please try again later.</p>");
                }
            });
        });
    </script>

    <!-- Footer -->
    <footer>
        <custom:currentDate />
    </footer>

</body>
</html>
