class Otpbar < Formula
  desc "Menu bar TOTP app and CLI for macOS; imports Google Authenticator exports"
  homepage "https://github.com/bamin0422/otpbar"
  url "https://github.com/bamin0422/otpbar/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "70f247603a7d647531085699baaf2736037b72727a4825759bbeb1daa45fd84f"
  license "MIT"
  head "https://github.com/bamin0422/otpbar.git", branch: "main"

  depends_on macos: :ventura

  def install
    # QR 디코더 (Vision 프레임워크)
    system "swiftc", "-O", "tools/otpqr.swift", "-o", "otpqr"

    # 메뉴바 앱 번들
    app = buildpath/"OTPBar.app/Contents"
    (app/"MacOS").mkpath
    (app/"Resources").mkpath
    cp "app/Info.plist", app/"Info.plist"
    system "swiftc", "-O", "app/main.swift", "-o", app/"MacOS/OTPBar"
    system "codesign", "--force", "--sign", "-", buildpath/"OTPBar.app"

    prefix.install "OTPBar.app"
    bin.install "cli/otp"
    bin.install "otpqr"

    # 메뉴바 앱 실행용 런처
    (bin/"otpbar").write <<~EOS
      #!/bin/bash
      exec open "#{opt_prefix}/OTPBar.app"
    EOS
  end

  # brew services start otpbar → 로그인 시 메뉴바 앱 자동 실행
  service do
    run [opt_prefix/"OTPBar.app/Contents/MacOS/OTPBar"]
    keep_alive false
    log_path var/"log/otpbar.log"
    error_log_path var/"log/otpbar.log"
  end

  def caveats
    <<~EOS
      메뉴바 앱 실행:        otpbar
      로그인 시 자동 실행:   brew services start otpbar
      Google OTP 가져오기:   otp import <계정 내보내기 QR 이미지>
      Claude 등 자동화에서:  otp get <계정> --purpose "<용도>"

      비밀키는 macOS Keychain(service "otpbar")에만 저장되며,
      계정 메타데이터는 ~/.config/otpbar/accounts.json 에 있습니다.
    EOS
  end

  test do
    system bin/"otp", "--version"
    system bin/"otp", "selftest"
    assert_predicate prefix/"OTPBar.app/Contents/MacOS/OTPBar", :executable?
  end
end
