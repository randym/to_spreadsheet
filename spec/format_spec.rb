require 'spec_helper'

describe ToSpreadsheet::Axlsx::Formatter do
  let :spreadsheet do
    build_spreadsheet haml: <<-HAML
:ruby
  format_xls do
    format column: 0, width: 25
    format 'tr', color: lambda { |row| 'cccccc' if row.index.odd? }
  end
%table
  %tr
    %th
  %tr
    %td
    HAML
  end

  let(:sheet) { spreadsheet.workbook.worksheets[0] }

  context 'local styles' do
    it 'sets column width' do
      sheet.column_info[0].width.should == 25
    end
    it 'runs lambdas' do
      sheet.rows[1].cells[0].color.rgb.should == Axlsx::Color.new(rgb: 'cccccc').rgb
    end
  end
end
