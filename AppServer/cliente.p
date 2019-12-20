@openapi.openedge.export FILE(type="REST", executionMode="single-run", useReturnValue="false", writeDataSetBeforeImage="false").

/*------------------------------------------------------------------------
    File        : cliente.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : Alan Aguilar
    Created     : Mon Aug 19 17:55:35 CDT 2019
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */
{incluidos/customer.i}

/* ***************************  Main Block  *************************** */



/* **********************  Internal Procedures  *********************** */

@openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
PROCEDURE actualizaCliente:
/*------------------------------------------------------------------------------
 Purpose:
 Notes:
------------------------------------------------------------------------------*/
 /* DEFINE INPUT-OUTPUT PARAMETER DATASET FOR dsCustomer.
    FOR FIRST ttCustomer NO-LOCK:
        FIND Customer WHERE Customer.CustNum = ttCustomer.CustNum EXCLUSIVE-LOCK NO-ERROR.
        IF AVAILABLE Customer THEN ASSIGN Customer.CustNum  = ttCustomer.CustNum
                                          Customer.Name     = ttCustomer.Name
                                          Customer.Address  = ttCustomer.Address
                                          Customer.Address2 = ttCustomer.Address2
                                          Customer.City     = ttCustomer.City.
        RELEASE Customer.
    END.  */
    DEFINE INPUT PARAMETER edita_CustNum AS INTEGER.
    DEFINE INPUT PARAMETER edita_Country AS CHARACTER.
    DEFINE INPUT PARAMETER edita_Name AS CHARACTER.
    DEFINE INPUT PARAMETER edita_Address AS CHARACTER.
    DEFINE INPUT PARAMETER edita_Address2 AS CHARACTER.
    DEFINE INPUT PARAMETER edita_City AS CHARACTER.
    DEFINE INPUT PARAMETER edita_State AS CHARACTER.
    DEFINE INPUT PARAMETER edita_PostalCode AS CHARACTER.
    DEFINE INPUT PARAMETER edita_Contact AS CHARACTER.
    DEFINE INPUT PARAMETER edita_Phone AS CHARACTER.
    DEFINE INPUT PARAMETER edita_SalesRep AS CHARACTER.
    DEFINE INPUT PARAMETER edita_CreditLimit AS DECIMAL.
    DEFINE INPUT PARAMETER edita_Balance AS DECIMAL.
    DEFINE INPUT PARAMETER edita_Terms AS CHARACTER.
    DEFINE INPUT PARAMETER edita_Discount AS INTEGER.
    DEFINE INPUT PARAMETER edita_Comments AS CHARACTER.
    DEFINE INPUT PARAMETER edita_Fax AS CHARACTER.
    DEFINE INPUT PARAMETER edita_EmailAddress AS CHARACTER.
    
    DEFINE OUTPUT PARAMETER DATASET FOR dsCustomer.
    
    FIND FIRST Customer WHERE Customer.CustNum = edita_CustNum NO-ERROR.
    IF NOT AVAILABLE Customer THEN DO:
        MESSAGE "No existe el valor a consultar".
    END.
    ASSIGN  Customer.CustNum      = edita_CustNum
            Customer.Country      = edita_Country
            Customer.Name         = edita_Name
            Customer.Address      = edita_Address
            Customer.Address2     = edita_Address2
            Customer.City         = edita_City
            Customer.State        = edita_State
            Customer.PostalCode   = edita_PostalCode
            Customer.Contact      = edita_Contact
            Customer.Phone        = edita_Phone
            Customer.SalesRep     = edita_SalesRep
            Customer.CreditLimit  = edita_CreditLimit
            Customer.Balance      = edita_Balance
            Customer.Terms        = edita_Terms
            Customer.Discount     = edita_Discount
            Customer.Comments     = edita_Comments
            Customer.Fax          = edita_Fax
            Customer.EmailAddress = edita_EmailAddress
     NO-ERROR.
     
     FOR EACH Customer NO-LOCK:
         FIND FIRST ttCustomer WHERE ttCustomer.CustNum = Customer.CustNum NO-ERROR.
         IF NOT AVAILABLE ttCustomer THEN
         DO:
             CREATE ttCustomer.
             BUFFER-COPY Customer TO ttCustomer.
             RELEASE ttCustomer.
         END.
     END.    

END PROCEDURE.



@openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
PROCEDURE borraCliente:
/*------------------------------------------------------------------------------
 Purpose:
 Notes:
------------------------------------------------------------------------------*/
/*  DEFINE INPUT-OUTPUT PARAMETER DATASET FOR dsCustomer.
    FOR FIRST ttCustomer NO-LOCK:
        FIND Customer WHERE Customer.CustNum = ttcustomer.CustNum EXCLUSIVE-LOCK NO-ERROR.
        IF AVAILABLE Customer THEN DELETE Customer.
    END.  */
    DEFINE INPUT PARAMETER IdClieDel AS INTEGER.
    DEFINE OUTPUT PARAMETER DATASET FOR dsCustomer.
    
    FOR FIRST Customer WHERE Customer.CustNum = IdClieDel EXCLUSIVE-LOCK:
        IF AVAILABLE Customer THEN DELETE Customer.
        ELSE DO:
            MESSAGE "El Cliente solicitado no existe" ttCustomer.CustNum.
            UNDO, THROW NEW Progress.Lang.AppError("Favor de poner un numero de cliente valido").
        END.
    END.
    FOR EACH Customer NO-LOCK:
        BUFFER-COPY Customer TO ttCustomer.
        RELEASE ttCustomer.
    END.

END PROCEDURE.

@openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
PROCEDURE crearCliente:
/*------------------------------------------------------------------------------
 Purpose:
 Notes:
------------------------------------------------------------------------------*/
 /* DEFINE INPUT-OUTPUT PARAMETER DATASET FOR dsCustomer.

    FOR FIRST ttCustomer NO-LOCK:
        FIND Customer WHERE Customer.CustNum = ttCustomer.CustNum NO-LOCK NO-ERROR.
    
    IF NOT AVAILABLE Customer THEN
    DO:
        IF ttCustomer.CustNum = ? THEN
        DO:
            MESSAGE "Nombre del cliente esta vacio" ttCustomer.CustNum.
            UNDO, THROW NEW Progress.Lang.AppError("Favor de poner un nombre de Cliente valido").
        END.
        BUFFER-COPY ttCustomer TO Customer.
        RELEASE Customer.
    END.
    ELSE
        DO:
            MESSAGE "Registro del cliente ya existente = " ttCustomer.CustNum.
            UNDO, THROW NEW Progress.Lang.AppError("Registro de clientes ya existente").
        END.
    END.    */
    DEFINE INPUT PARAMETER paso_CustNum AS INTEGER.
    DEFINE INPUT PARAMETER paso_Country AS CHARACTER.
    DEFINE INPUT PARAMETER paso_Name AS CHARACTER.
    DEFINE INPUT PARAMETER paso_Address AS CHARACTER.
    DEFINE INPUT PARAMETER paso_Address2 AS CHARACTER.
    DEFINE INPUT PARAMETER paso_City AS CHARACTER.
    DEFINE INPUT PARAMETER paso_State AS CHARACTER.
    DEFINE INPUT PARAMETER paso_PostalCode AS CHARACTER.
    DEFINE INPUT PARAMETER paso_Contact AS CHARACTER.
    DEFINE INPUT PARAMETER paso_Phone AS CHARACTER.
    DEFINE INPUT PARAMETER paso_SalesRep AS CHARACTER.
    DEFINE INPUT PARAMETER paso_CreditLimit AS DECIMAL.
    DEFINE INPUT PARAMETER paso_Balance AS DECIMAL.
    DEFINE INPUT PARAMETER paso_Terms AS CHARACTER.
    DEFINE INPUT PARAMETER paso_Discount AS INTEGER.
    DEFINE INPUT PARAMETER paso_Comments AS CHARACTER.
    DEFINE INPUT PARAMETER paso_Fax AS CHARACTER.
    DEFINE INPUT PARAMETER paso_EmailAddress AS CHARACTER.
    
    DEFINE OUTPUT PARAMETER DATASET FOR dsCustomer.
    
    INSERT INTO Customer( CustNum,
                          Country,
                          Name,
                          Address,
                          Address2,
                          City,
                          State,
                          PostalCode,
                          Contact,
                          Phone,
                          SalesRep,
                          CreditLimit,
                          Balance,
                          Terms,
                          Discount,
                          Comments,
                          Fax,
                          EmailAddress) 
                VALUES( paso_CustNum,
                        paso_Country,
                        paso_Name,
                        paso_Address,
                        paso_Address2,
                        paso_City,
                        paso_State,
                        paso_PostalCode,
                        paso_Contact,
                        paso_Phone,
                        paso_SalesRep,
                        paso_CreditLimit,
                        paso_Balance,
                        paso_Terms,
                        paso_Discount,
                        paso_Comments,
                        paso_Fax,
                        paso_EmailAddress).
    FOR EACH Customer NO-LOCK:
        FIND FIRST ttCustomer WHERE ttCustomer.CustNum = Customer.CustNum NO-ERROR.
        IF NOT AVAILABLE ttCustomer THEN
        DO:
            CREATE ttCustomer.
            BUFFER-COPY Customer TO ttCustomer.
            RELEASE ttCustomer.
        END.
    END.
    
END PROCEDURE.

@openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
PROCEDURE leeCliente:
/*------------------------------------------------------------------------------
 Purpose:
 Notes:
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER IdCust AS CHARACTER NO-UNDO.
    DEFINE OUTPUT PARAMETER DATASET FOR dsCustomer.
    
    DEFINE VARIABLE iCustNum AS INTEGER NO-UNDO.
    iCustNum = INTEGER(IdCust) NO-ERROR.
    
    MESSAGE "DEBUG: " iCustNum.
    IF ERROR-STATUS:ERROR THEN UNDO, THROW NEW Progress.Lang.AppError("Filtro invalido").
    
   EMPTY TEMP-TABLE ttCustomer.
   FOR EACH Customer WHERE (IF IdCust <> ? THEN Customer.CustNum = iCustNum ELSE TRUE) NO-LOCK:
       BUFFER-COPY Customer TO ttCustomer.
       RELEASE ttCustomer.
   END.

END PROCEDURE.

