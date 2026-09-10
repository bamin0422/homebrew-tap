# homebrew-tap

[Portfolio](https://github.com/bamin0422/portfolio) 설치용 Homebrew tap.

```bash
brew install --cask bamin0422/tap/portfolio
```

## otpbar

[OTPBar](https://github.com/bamin0422/otpbar) — macOS 메뉴바 TOTP 앱 + CLI. Google Authenticator 내보내기 QR을 가져와 Keychain에 보관합니다.

```bash
brew install bamin0422/tap/otpbar
otpbar                      # 메뉴바 앱 실행
brew services start otpbar  # 로그인 시 자동 실행
otp import <QR 이미지>       # Google OTP 계정 가져오기
```
