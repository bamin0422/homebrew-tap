cask "portfolio" do
  version "0.1.0"

  on_arm do
    sha256 "e84c6eb5e58cc4be4bf5baf0aaf8efd675d160283e580c2177c4bd7602290ada"
    url "https://github.com/bamin0422/portfolio/releases/download/v#{version}/Portfolio-#{version}-arm64.dmg"
  end
  on_intel do
    sha256 "8acbf9f1dee18c9f14c0bba955cdf4fa9721324c60b3eeddfabd7c249c976ec4"
    url "https://github.com/bamin0422/portfolio/releases/download/v#{version}/Portfolio-#{version}.dmg"
  end

  name "Portfolio"
  desc "로컬 개발 포트를 한곳에서 관리하는 IDE형 데스크톱 앱"
  homepage "https://github.com/bamin0422/portfolio"

  app "Portfolio.app"

  zap trash: [
    "~/Library/Application Support/Portfolio",
    "~/Library/Preferences/dev.portfolio.app.plist",
    "~/Library/Saved Application State/dev.portfolio.app.savedState",
  ]
end
