
/*------------------------------------------------------------------------
    File        : todosLosClientes.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : Alan Aguilar
    Created     : Thu Oct 10 12:37:42 CDT 2019
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */
{incluidos/customer.i}

/* ***************************  Main Block  *************************** */
DEFINE OUTPUT PARAMETER TABLE FOR ttCustomer.
DEFINE OUTPUT PARAMETER registrosTotales AS INTEGER.

FOR EACH Customer NO-LOCK:
    FIND FIRST ttCustomer WHERE ttCustomer.CustNum = Customer.CustNum NO-ERROR.
    IF NOT AVAILABLE ttCustomer THEN
    DO:
        CREATE ttCustomer.
        BUFFER-COPY Customer TO ttCustomer.
        RELEASE ttCustomer.
    END.
    registrosTotales = registrosTotales + 1.
END.
