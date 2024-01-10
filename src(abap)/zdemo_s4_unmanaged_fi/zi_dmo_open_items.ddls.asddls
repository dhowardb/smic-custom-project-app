@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo Interface for FI open items'
define root view entity ZI_DMO_OPEN_ITEMS
  as select from bsid_view
{
  key belnr as DocumentNumber,
  key bukrs as CompanyCode,
  key kunnr as CustomerNumber,
  key gjahr as FiscalYear,
  key augbl as ClearingDocument,
  key buzei as DocumentLine,
  key umsks as GLTransactionType,
  key umskz as GLIndicator,
  key zuonr as AssignmentNumber,
      augdt as ClearingDate,
      blart as DocumentType,
      xblnr as Description,
      shkzg as DebitCreditIndicator,
      waers as CurrencyCode,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      dmbtr as DocAmount
}
