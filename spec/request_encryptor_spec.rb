RSpec.describe NetcashApi::RequestEncryptor do
  describe '.encrypt' do

    subject { NetcashApi::RequestEncryptor }

    it 'should generate a valid encryption key' do
      message = subject.encrypt(value: NetcashApi::Request.new.xml, pass_key: NetcashApi::Request::PIN)
      response = HTTParty.post('https://mobi.netcash.co.za/authenticate.aspx',
        body: "key=#{NetcashApi::Request::USERNAME}&message=#{message}")
    end
  end
end
