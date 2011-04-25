class ::Hash
   def method_missing(name)
     return self[name] if key? name
     self.each { |k,v| return v if k.to_s.to_sym == name }
     super.method_missing name
   end
 end
