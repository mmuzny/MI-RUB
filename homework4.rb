class Decipher

  #Class decryption method
  def self.decrypt(line)
     line.each_byte do |c|
        print (c-7).chr
     end
  end

  #Class encryption method
  def self.encrypt(line)
     line.each_byte do |c|
        print (c+7).chr
     end
  end

end

#Read input lines and print solution
while line = STDIN.gets
   Decipher.decrypt(line.chomp)
   puts
end