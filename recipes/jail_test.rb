jail 'www.example.com'

jail 'www2.example.com' do
  interface 'lo0'
end

jail 'www3.example.com' do
  ipaddress '192.168.100.10'
end
