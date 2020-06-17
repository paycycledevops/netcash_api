require 'openssl'
require 'base64'

# WIP

module NetcashApi
  class RequestEncryptor
    class << self
      SALT = [ 0x49, 0x76, 0x61, 0x6E, 0x20, 0x4D, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 ]

      def encrypt(value:, pass_key:)
        pbdk1_32 = pbdk1(32, pass_key)
        pbdk1_16 = pbdk1(16, pass_key)

        cipher = cipher(data: pbdk1_32, key: pbdk1_16, iv: value)
        Base64.encode64(cipher.gsub(['/', '+', '='], ['_', '|', ']']))
      end

      private

      def pbdk1(key_length, pass_key)
        base = Digest::SHA1.hexdigest SALT.map(&:chr).join

        98.times do |i|
          base = Digest::SHA1.hexdigest(base)
        end

        clen = 0
        remain = key_length
        hashno = 0

        while(remain > clen) do
          if hashno == 0
            current = Digest::SHA1.hexdigest base
          elsif hashno < 1000
            n = hashno.to_f
            current += Digest::SHA1.hexdigest(n + base)
          end

          hashno++
          clen = current.length
        end

        return current[0..remain]
      end

      def cipher(data:, key:, iv:)
        cipher = OpenSSL::Cipher.new("aes-128-cbc")

        utf16le_data = data.encode('utf-16le')
        block = cipher.block_size
        padding = block - (utf16le_data.length % block)
        utf16le_data += (padding.chr * padding).encode('utf-16le')

        cipher.encrypt
        cipher.key = key
        cipher.iv = iv
        encrypted = cipher.update(utf16le_data)
        encrypted << cipher.final
      end
    end
  end
end
