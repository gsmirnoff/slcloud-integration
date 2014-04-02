class FindCriteria
  def initialize (ns = 'typ1', params = {})
    @ns = ns
    @params = params
  end

  def to_s
    xml_builder = Builder::XmlMarkup.new
    xml_builder.typ :findCriteria do |xml|
      xml.tag!("#{@ns}:fetchStart", 0)
      xml.tag!("#{@ns}:fetchSize", -1)
      filter(@params, xml) if @params
    end
  end

  def filter(where, xml)
    xml.tag! "#{@ns}:filter" do |filter_xml|
      filter_xml.tag! "#{@ns}:group" do |group_xml|
        where.each do |a, v|
          group_xml.tag! "#{@ns}:upperCaseCompare", false
          add_filter(a.to_s.camelize, v, group_xml)
        end if where
      end
    end
  end

  def add_filter(a, v, xml, o='=')
    xml.tag! "#{@ns}:item" do |x|
      #x.tag! "#{@ns}:conjunction", "And" # Hard Coded ... for now
      x.tag! "#{@ns}:upperCaseCompare", false # Hard Coded ... for now
      x.tag! "#{@ns}:attribute", a
      x.tag! "#{@ns}:operator", o # Hard Coded ... for now
      x.tag! "#{@ns}:value", v
    end
  end

end
