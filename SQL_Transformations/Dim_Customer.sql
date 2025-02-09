-----Query to join Customer and Geography Table------- 

select c.CustomerID,c.CustomerName,c.Email,c.Gender,c.Age,g.City,g.Country 
  from Customers C 
  left join geography g
  on c.GeographyID = g.GeographyID

------Create Dimension Table----------------

  create table Dim_Customer

  (CustomerID INT,
   CustomerName NVarchar(255),
   Email NVarchar(255),
   Gender NVarchar(55),
   Age INT,
   City NVarchar(255),
   Country NVarchar(255)
  );

------Insert Data into the Dimesion table using SQL Query-----------

  Insert into Dim_Customer (CustomerID,CustomerName,Email,Gender,Age,City,Country )
  
select c.CustomerID,c.CustomerName,c.Email,c.Gender,c.Age,g.City,g.Country 
  from Customers C 
  left join geography g
  on c.GeographyID = g.GeographyID;
