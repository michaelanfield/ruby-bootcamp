require 'page_magic'

class BillPage
  include PageMagic

  def self.paths; ['/bill']; end

  button :logout_button, text: 'Logout'
  element :header_title, css: 'h1.header-title' 
  element :header_logo, css: 'img.header-logo'
  element :statement_period, css: 'h2.statement-period' do
    element :from, css: 'span.statement-period-from'
    element :to, css: 'span.statement-period-to'
  end

  element :packages_section, id: 'package-breakdown-detail'
  element :packages, css: 'div.packages' do
    element :title, css: 'div.breakdown-heading-title'
    element :cost, css: 'div.breakdown-total'
    element :breakdown, id: 'package-breakdown' do
      element :subscriptions, css: 'table'
    end
  end

  element :call_charges_section, id: 'call-breakdown-detail'
  element :calls, css: 'div.calls' do
    element :title, css: 'div.breakdown-heading-title'
    element :cost, css: 'div.breakdown-total'
    element :breakdown, id: 'call-breakdown' do
      element :call_history, css: 'table'
    end
  end

  element :sky_store_section, id: 'skystore-breakdown-detail'
  element :sky_store, css: 'div.skystore' do
    element :title, css: 'div.breakdown-heading-title'
    element :cost, css: 'div.breakdown-total'
    element :breakdown, id: 'skystore-breakdown' do
      # element :call_history, css: 'table'
    end
  end

  def arrived; 'Your Bill' == title; end
end