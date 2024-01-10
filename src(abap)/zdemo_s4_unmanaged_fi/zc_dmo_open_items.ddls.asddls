@EndUserText.label: 'Demo Projection for FI open items'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.semanticKey: ['DocumentNumber']
@Metadata.allowExtensions: true
define root view entity ZC_DMO_OPEN_ITEMS 
provider contract transactional_query 
as projection on ZI_DMO_OPEN_ITEMS 
{
    key DocumentNumber,
    key CompanyCode,
    key CustomerNumber,
    key FiscalYear,
    key ClearingDocument,
    key DocumentLine,
    key GLTransactionType,
    key GLIndicator,
    key AssignmentNumber,
    ClearingDate,
    DocumentType,
    Description,
    DebitCreditIndicator,
    CurrencyCode,
    DocAmount
}
