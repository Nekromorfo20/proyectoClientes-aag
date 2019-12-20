@openapi.openedge.export FILE(type="REST", executionMode="single-run", useReturnValue="false", writeDataSetBeforeImage="false").

/*------------------------------------------------------------------------
    File        : clientes_todos.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : Alan Aguilar
    Created     : Thu Oct 10 12:35:02 CDT 2019
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */
{incluidos/customer.i}

/* ***************************  Main Block  *************************** */



/* **********************  Internal Procedures  *********************** */

@openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
PROCEDURE leerTodosClientes:
/*------------------------------------------------------------------------------
 Purpose:
 Notes:
------------------------------------------------------------------------------*/
DEFINE OUTPUT PARAMETER DATASET FOR dsCustomer.
DEFINE OUTPUT PARAMETER registrosTotales AS INTEGER.

    RUN todosLosClientes.p(OUTPUT TABLE ttCustomer, OUTPUT registrosTotales).

END PROCEDURE.


