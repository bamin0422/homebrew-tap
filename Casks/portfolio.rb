cask "portfolio" do
  version "0.1.2"

  on_arm do
    sha256 "2c9c3e9f4cbdb754ad0581296c67fa46c7a2596f6d767e82ec679a8e385dc802"
    url "https://github.com/bamin0422/portfolio/releases/download/v#{version}/Portfolio-#{version}-arm64.dmg"
  end
  on_intel do
    sha256 "0b1b9a5d7ff47345800df068e1e3b766fd6cd83ad85f5cb70203337e700b4479"
    url "https://github.com/bamin0422/portfolio/releases/download/v#{version}/Portfolio-#{version}.dmg"
  end

  name "Portfolio"
  desc "로컬 개발 포트를 한곳에서 관리하는 IDE형 데스크톱 앱"
  homepage "https://github.com/bamin0422/portfolio"

  app "Portfolio.app"

  # 서명·공증이 없으므로 설치 후 quarantine 속성을 제거해 바로 실행되게 한다.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/Portfolio.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/Portfolio",
    "~/Library/Preferences/dev.portfolio.app.plist",
    "~/Library/Saved Application State/dev.portfolio.app.savedState",
  ]
end
