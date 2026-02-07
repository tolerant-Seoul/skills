# World Mini App Skill for Claude Code

World Mini App 개발을 위한 Claude Code 스킬입니다. World ID, MiniKit SDK, World Chain 관련 개발 가이드를 제공합니다.

## 설치 방법

### 방법 1: One-liner 설치 (권장)

```bash
curl -fsSL https://raw.githubusercontent.com/tolerant-Seoul/skills/main/world-miniapp/install.sh | bash
```

### 방법 2: Git Clone 후 로컬 설치

```bash
git clone https://github.com/tolerant-Seoul/skills.git
cd skills/world-miniapp
chmod +x install-local.sh
./install-local.sh
```

### 방법 3: 수동 설치

```bash
# 스킬 디렉토리 생성
mkdir -p ~/.claude/skills/world-miniapp/references

# 파일 복사
cp SKILL.md ~/.claude/skills/world-miniapp/
cp references/*.md ~/.claude/skills/world-miniapp/references/
```

## 사용법

Claude Code에서 `/world` 명령어로 스킬을 활성화합니다.

```
/world
```

또는 World App, MiniKit, World ID 관련 질문을 하면 자동으로 활성화됩니다.

## 제거

```bash
curl -fsSL https://raw.githubusercontent.com/tolerant-Seoul/skills/main/world-miniapp/uninstall.sh | bash
```

또는:

```bash
rm -rf ~/.claude/skills/world-miniapp
```

## 포함된 기능

- **MiniKit SDK 통합**: 설치, 설정, 명령어 레퍼런스
- **World ID 인증**: Orb/Device 검증, ZK 프루프 처리
- **결제 시스템**: WLD/USDC 결제, 트랜잭션 검증
- **스마트 컨트랙트**: World Chain 트랜잭션 가이드
- **알림 & 딥링크**: 푸시 알림, 앱 딥링크 구현
- **백엔드 검증**: SIWE, 프루프 검증, 보안 패턴

## 파일 구조

```
~/.claude/skills/world-miniapp/
├── SKILL.md                         # 메인 스킬 정의
└── references/
    ├── api-endpoints.md             # API 엔드포인트 레퍼런스
    ├── backend-verification.md      # 백엔드 검증 패턴
    ├── deep-links.md                # 딥링크 가이드
    └── minikit-commands.md          # MiniKit 명령어 퀵 레퍼런스
```

## 라이선스

MIT
