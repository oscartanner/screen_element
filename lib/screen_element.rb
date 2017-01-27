class ScreenElement
  def element(name, type = :pending, identificator = '')
    define_method(name.to_s) { Element.new type, identificator }
  end
end
