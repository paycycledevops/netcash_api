module NetcashApi
  class Request
    GUID = '24ade73c-98cf-47b3-99be-cc7b867b3080'
    USERNAME = ''
    PASSWORD = ''
    PIN = ''

    def xml
      "<?xml version='1.0'?>
<netcashRequest xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema'>
  <BasePage>2</BasePage>
  <ConsentObtained>Yes</ConsentObtained>
  <CreditAmount>0</CreditAmount>
  <CreditTerms>COD</CreditTerms>
  <AccountReference>netcashTest-1022-3942</AccountReference>
  <Extra1>sfsdfsdfdsfdsf</Extra1>
  <Extra2 />
  <Extra3 />
  <SecurityHeader>
    <SoftwareVendorKey>#{GUID}</SoftwareVendorKey>
    <Username>#{USERNAME}</Username>
    <Password>#{PASSWORD}</Password>
    <Pin>#{PIN}</Pin>
  </SecurityHeader>
  <BusinessDetails />
  <ConsumerDetails>
    <Identifier>6001234567890</Identifier>
    <Firstname>Mike</Firstname>
    <Surname>Larry</Surname>
    <DateOfBirth>1960-02-10T00:00:00</DateOfBirth>
  </ConsumerDetails>
  <Address />
  <TradeReferences />
  <Qualifications />
  <ClientsReferences />
  <BankAccounts />
  <LegalDetails />
  <AdditionalInfo />
</netcashRequest>"
    end
  end
end
