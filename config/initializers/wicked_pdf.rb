WickedPdf.config = {
  #:wkhtmltopdf => '/usr/local/bin/wkhtmltopdf',
  #:layout => "pdf.html",
  :exe_path => STANFORD68 || (Rails.env == "production") ? '/opt/saiswebapp/.rvm/gems/ruby-2.1.2@rsas_dev/bin/wkhtmltopdf' : '/usr/bin/wkhtmltopdf'
}
