
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
   Category		       int foreign key references category(Id)
)

create or alter procedure [dbo].[sp_AddProduct]

  @Product_SKU		    varchar(20), 
  @Product_Name		    varchar(50), 
  @Product_Price	    decimal, 
  @Product_Description  varchar(300),
  @Product_Discount     decimal, 
  @Product_Color	    varchar(30),
  @Product_Size		    varchar(20),
  @Product_Image        varchar(200),
  @Department           int, 
  @Category		        int  
 
AS

  BEGIN
      declare @Product_Id as BIGINT
      insert into product(
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
	  Set @Product_Id = SCOPE_IDENTITY();
	  Select @Product_Id as Id

  END

  create or alter procedure [dbo].[sp_GetAllProducts]


AS

  BEGIN
     select * from 
	 product p inner join category c 
  on 
     p.Product_Id = c.Id inner join department d 
  on 
     c.Id = d.Id
  
  END

 create or alter procedure [dbo].[sp_GetProduct]
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


  create procedure [dbo].[sp_DeleteCategory]
 @Id int

AS

  BEGIN
      Delete from category 
	  Where
	  Id = @Id
  END






  select * from department
  select * from category
  select * from Product