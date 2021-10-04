
create database ecommerceDB

select * from department

create table department
(
   Id int primary key identity(1,1),
   Name varchar(50) not null unique,
   Location varchar(100),
   Number int
)

create procedure [dbo].[Adddeps]

 @Name varchar(50),
 @Location varchar(100),
 @Number int

AS

  BEGIN
      declare @Id as BIGINT
      insert into department (
	   Name,
	   Location,
	   Number
	  )
	  Values(
	   @Name,
	   @Location,
	   @Number
	  );
	  Set @Id = SCOPE_IDENTITY();
	  Select @Id as Id

  END

  create procedure [dbo].[GetAlldeps]


AS

  BEGIN
  
    Select * from department
	Select * from category

  END

 create procedure [dbo].[Getdep]
 @Id int

AS

  BEGIN
  
    Select * from department where Id = @Id

  END


create procedure [dbo].[Editdeps]
 @Id int,
 @Name varchar(50),
 @Location varchar(100),
 @Number int

AS

  BEGIN
      Update department 
	  set 
	  Name	   = @Name,
	  Location = @Location,
	  Number   = @Number
	  Where
	  Id = @Id
  END



  ----------------------

  select * from category

create table category
(
   Id int primary key identity(1,1),
   CatName varchar(50) not null unique,
   Department int foreign key references department(Id)
)

create or alter procedure [dbo].[sp_AddCategory]

 @CatName varchar(50),
 @Department int

AS

  BEGIN
      declare @Id as BIGINT
      insert into category (
	   CatName,
	   Department
	  )
	  Values(
	   @CatName,
	   @Department
	  );
	  Set @Id = SCOPE_IDENTITY();
	  Select @Id as Id

  END

  create or alter procedure [dbo].[sp_GetAllCategories]


AS

  BEGIN
  
    Select c.Id, d.Name, c.CatName from category c inner join department d on c.Department = d.Id

  END

 create or alter procedure [dbo].[sp_GetCategory]
 @Id int

AS

  BEGIN
   
    Select c.Id, d.Name, c.CatName from category c inner join department d on c.Department = d.Id where c.Id = @Id

  END


create or alter procedure [dbo].[sp_EditCategory]
 @Id int,
 @CatName varchar(50),
 @Department int

AS

  BEGIN
      Update category 
	  set 
	  CatName	     = @CatName,
	  Department = @Department
	  Where
	  Id = @Id
  END


  create or alter procedure [dbo].[sp_GetCatByDep]
 @DepId int

AS

  BEGIN
  
    Select c.Id, c.CatName, d.Id from category c inner join department d on d.Id = c.Department where d.Id = @DepId

  END

  -----------------

  create procedure [dbo].[sp_DeleteCategory]
 @Id int

AS

  BEGIN
      Delete from category 
	  Where
	  Id = @Id
  END

  create or alter procedure [dbo].[Searchdeps]
  @Value varchar(50)
AS

  BEGIN
     Select * from department where Name like '%'+@Value+'%'
  END



  ----------------------

  create table product
(
   Product_Id          int primary key identity(1,1),
   Product_SKU		   varchar(20) unique,
   Product_Name		   varchar(50) not null unique,
   Product_Price	   decimal not null,
   Product_Description varchar(300),
   Product_Discount    decimal, 
   Product_Color	   varchar(30),
   Product_Size		   varchar(20),
   Product_Image       varchar(200),
   Department          int foreign key references department(Id),
   Category		       int foreign key references category(Id),
)

create or alter procedure [dbo].[sp_Product_IUD]
  @Product_Id           int,
  @Product_SKU		    varchar(20), 
  @Product_Name		    varchar(50), 
  @Product_Price	    decimal, 
  @Product_Description  varchar(300),
  @Product_Discount     decimal, 
  @Product_Color	    varchar(30),
  @Product_Size		    varchar(20),
  @Product_Image        varchar(200),
  @Department           int, 
  @Category		        int,
  @iud_value		    char(1)	  
 
AS

 IF @iud_value = 'U'

  BEGIN
      
      UPDATE product
	  SET
	   Product_SKU		   = @Product_SKU,		  
	   Product_Name		   = @Product_Name,		  
	   Product_Price	   = @Product_Price,	  
	   Product_Description = @Product_Description,
	   Product_Discount    = @Product_Discount ,   
	   Product_Color       = @Product_Color,	  
	   Product_Size		   = @Product_Size,		  
	   Product_Image	   = @Product_Image,      
	   Department		   = @Department,         
	   Category			   = @Category	      
	  
       WHERE
	      
		  Product_Id = @Product_Id

  END

  IF @iud_value = 'I'  

   BEGIN
      INSERT into product(
	   Product_SKU,		  
	   Product_Name,		  
	   Product_Price,	  
	   Product_Description,
	   Product_Discount,   
	   Product_Color,	  
	   Product_Size,		  
	   Product_Image,      
	   Department,         
	   Category		      
	  )
	  Values(
	   @Product_SKU,		  
	   @Product_Name,		  
	   @Product_Price,	  
	   @Product_Description,
	   @Product_Discount,   
	   @Product_Color,	  
	   @Product_Size,		  
	   @Product_Image,      
	   @Department,         
	   @Category		      
	  );
	 

  END

   IF @iud_value = 'D'  

   BEGIN
      DELETE FROM product
	  WHERE 
	  Product_Id = @Product_Id 
  END

  create or alter procedure [dbo].[sp_GetAllProducts]


AS

  BEGIN
     select * from 
	 department d inner join category c 
  on 
     d.Id = c.Department inner join product p 
  on 
      p.Category   = c.Id and
	  p.Department = d.Id
  
  END

 create or alter procedure [dbo].[sp_GetProduct]
 @Product_Id int 

AS

  BEGIN
  Select 
        p.Product_Id,
		p.Product_Name,
		p.Product_Price,
		p.Product_Description,
		p.Product_Discount,
		p.Product_Color,
		p.Product_Size,
		p.Product_Image,
		p.Product_SKU,
		d.Id as Dep_Id,
		d.Name as Dep_Name,
		c.Id as Cat_Id,
		c.CatName as Cat_Name
   From
        department d Inner Join 
        category c
   On
        d.Id = c.Department Inner Join
		product p
   On
        p.Category   = c.Id and
		p.Department = d.Id
   Where
        p.Product_Id = @Product_Id
  END










  select * from department
  select * from category
  select * from Product


