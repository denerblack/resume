class HomeController < ApplicationController
  def index
  end

  def download_curriculum
    send_file(
      "#{Rails.root}/public/cv-dener.pdf",
      filename: "cv-dener.pdf",
      type: "application/pdf"
    )

    render nothing: true
  end
end
