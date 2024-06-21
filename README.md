 <h1>Beer Management App</h1>
 <p>Manage your beer inventory with ease!</p>


       
  <h2>Introduction</h2>
      <p>This iOS application allows users to manage beer inventory. You can preload data from a JSON file, add manufacturers classified as either national or imported, edit them, and add types of beers for these manufacturers, including editing their names, alcohol content, calories, and more.</p>

        
   <h2>Features</h2>
            <ul>
                <li>Preload data from a JSON file</li>
                <li>Add and edit manufacturers (national and imported)</li>
                <li>Add and edit beer types with details like name, alcohol content, and calories</li>
                <li>User-friendly interface with separate views for different functionalities</li>
            </ul>
      

        
  <h2>Application Views</h2>
            <h3>Main View (ContentView)</h3>
            <p>The main view displays a list of manufacturers, separated into national and imported sections. Users can add new manufacturers using the "+" button, which opens the <strong>AddManufacturerView</strong>.</p>

  <h3>AddManufacturerView</h3>
            <p>In this view, users can add a new manufacturer by filling out a form that includes the manufacturer's name, a toggle for national or imported, and an option to select an image. The "Add Manufacturer" button saves the data and updates the main view.</p>

  <h3>DetailManufacturerView</h3>
            <p>Upon selecting a manufacturer from the main view, users are taken to the detail view for that manufacturer, displaying a list of beers in their catalog. Users can add new beers using the "+" button and sort beers with the "⇅" button. A search bar is also available for finding specific beers.</p>
            
  <h3>AddBeerView</h3>
            <p>This auxiliary view allows users to add a new beer to the manufacturer's catalog by filling out a form with the beer's name, image, calories, and alcohol content.</p>

  <h3>SortBeer</h3>
            <p>This function displays a popup with sorting options for the beer list, allowing users to sort by name, calories, or alcohol content.</p>

   <h3>DetailBeerView</h3>
           <p>When a specific beer is selected from the detail view, this view displays additional details such as calories and alcohol content. An edit button allows users to modify these details using the <strong>EditBeerView</strong>.</p>

  <h3>EditBeerView</h3>
            <p>This view presents a form with the current details of the beer, allowing users to make changes. Users can save the changes or cancel to discard them.</p>

  <h2>Data Model (Manufacturer)</h2>
            <p>The data model includes structures for manufacturers and beers, supporting the functionality of adding and managing these entities.</p>

        
  <h2>View-Model (ManufacturerViewModel)</h2>
            <p>The view-model handles data loading from the JSON file, adding and deleting manufacturers, saving images, and updating beer details, ensuring synchronization between the model and views.</p>

  <h2>Conclusion</h2>
            <p>This project provided an enriching experience with SwiftUI, despite some challenges with image handling and view updates. The application successfully implements a robust beer management system using the MVVM architecture.</p>

