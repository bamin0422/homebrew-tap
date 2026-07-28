cask "portfolio" do
  version "0.1.0"

  on_arm do
    sha256 "48b87e2523f7e7ae80f2b7e024c870fdc61f8730520520a696253c8d93956f90"
    url "https://github.com/bamin0422/portfolio/releases/download/v#{version}/Portfolio-#{version}-arm64.dmg"
  end
  on_intel do
    sha256 "19f9d5dcd915f5aa209e7ab8ff8a26f6ed46aae5e8e4fc8d7cef2c4930f0a6fb"
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
