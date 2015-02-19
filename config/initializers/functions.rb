class Functions
  def self.ip_number(ip_addr)
    ip_addr.split('.').inject(0) {|total,value| (total << 8 ) + value.to_i}
  end
end