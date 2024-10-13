### **Automation Flow: Shopping Products Quiz**

---

#### **Step 1: Login with "Standard User"**
- **Action**: Enter valid credentials for the "Standard User" and click the login button.
- **Input Data**: 
    - Username: `standard_user`
    - Password: `secret_sauce`
- **Verification**: Check if login is successful by verifying if the URL changes or if the product list page appears.

---

#### **Step 2: Verify Login Success**
- **Action**: Validate that the user is successfully logged in.
- **Verification**: Ensure a product page element (like a product item or heading) is visible.

---

#### **Step 3: Sort Product Items by "Name Ascending" (A-Z)**
- **Action**: Select the sorting option in the dropdown and choose "Name (A-Z)".
- **Verification**: Confirm that the products are sorted alphabetically from A-Z by verifying the first few items' names.

---

#### **Step 4: Find and Click Product "Test.allTheThings() T-Shirt"**
- **Action**: Search for the product named `"Test.allTheThings() T-Shirt"` in the list and click on it.
- **Verification**: Verify that the correct product details page opens.

---

#### **Step 5: Get and Save Price of the Product, Then Click "Add to Cart"**
- **Action**: Capture the price of the product and store it for later verification. Then click the "Add to Cart" button.
- **Verification**: Ensure that the product is added to the cart successfully by checking that the cart icon is updated.

---

#### **Step 6: Verify "Cart" Icon Has Changed to "1"**
- **Action**: Inspect the cart icon in the header.
- **Verification**: Ensure the cart icon displays `1`, indicating that one item has been added to the cart.

---

#### **Step 7: Go to "Checkout Page"**
- **Action**: Click on the cart icon and navigate to the checkout page.
- **Verification**: Confirm that the user is on the checkout page by verifying the page's title or presence of a "Checkout" header.

---

#### **Step 8: Verify the Product Name and Price Are Correct**
- **Action**: Inspect the cart items and verify that the product `"Test.allTheThings() T-Shirt"` and its saved price match.
- **Verification**: Match the product name and price with the values stored in Step 5.

---

#### **Step 9: Click "Checkout" Button**
- **Action**: Click the "Checkout" button to proceed with the checkout process.
- **Verification**: Ensure the user is taken to the form to fill in personal details.

---

#### **Step 10: Fill in the Form with "Firstname, Lastname, Postal Code" Data**
- **Action**: Enter details in the form fields.
  - **Firstname**: Your choice (e.g., `John`)
  - **Lastname**: Your choice (e.g., `Doe`)
  - **Postal Code**: Your choice (e.g., `12345`)
- **Verification**: Ensure the form is filled correctly and ready to proceed.

---

#### **Step 11: Click "Continue" Button**
- **Action**: Click the "Continue" button after filling in the form.
- **Verification**: Confirm that the user proceeds to the next checkout page where the order summary is displayed.

---

#### **Step 12: Verify the Product Name and Price Are Correct Again**
- **Action**: On the order summary page, verify that the product name and price are displayed correctly.
- **Verification**: Match the product name and price with previously saved values.

---

#### **Step 13: Verify "Item Total", "Tax", and "Total" Are Correct**
- **Action**: Calculate the total price and tax, and verify they match the displayed values.
- **Verification**:
  - **Item Total**: Sum of the price of items.
  - **Tax**: Verify the tax amount.
  - **Total**: Ensure the final total matches the sum of the item total and tax.

---

#### **Step 14: Click "Finish" Button**
- **Action**: Click the "Finish" button to complete the purchase.
- **Verification**: Confirm that the purchase is processed and the user is directed to a success page.

---

#### **Step 15: Verify the Success Message**
- **Action**: Inspect the success message on the page.
- **Verification**: Ensure that a message like "Thank you for your order!" is displayed, indicating the purchase was successful.
