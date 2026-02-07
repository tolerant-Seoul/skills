# Claude Code Skills

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

[Claude Code](https://claude.ai/code)를 위한 커뮤니티 스킬 모음입니다.

## Available Skills

| Skill | Description | Install |
|-------|-------------|---------|
| [world-miniapp](./world-miniapp) | World Mini App 개발 (World ID, MiniKit, World Chain) | [설치](#world-miniapp) |

---

## Quick Install

### world-miniapp

World ID 인증, MiniKit SDK, World Chain 트랜잭션을 위한 개발 가이드 스킬입니다.

```bash
curl -fsSL https://raw.githubusercontent.com/tolerant-Seoul/skills/main/world-miniapp/install.sh | bash
```

설치 후 Claude Code에서 `/world` 명령어로 활성화합니다.

**포함 기능:**
- MiniKit SDK 설정 및 명령어 레퍼런스
- World ID (Orb/Device) 검증
- WLD/USDC 결제 처리
- 스마트 컨트랙트 트랜잭션
- 푸시 알림 및 딥링크
- 백엔드 검증 패턴

---

## What are Claude Code Skills?

스킬은 Claude Code에 도메인별 전문 지식을 추가하는 확장 기능입니다. 스킬을 설치하면 Claude가 해당 분야의 베스트 프랙티스, API 레퍼런스, 코드 패턴을 활용하여 더 정확한 답변을 제공합니다.

**스킬 설치 위치:** `~/.claude/skills/`

---

## Contributing

기여를 환영합니다! 새로운 스킬 추가, 버그 수정, 문서 개선 모두 감사히 받습니다.

### 새 스킬 추가하기

1. 이 저장소를 Fork합니다
2. 새 스킬 디렉토리를 생성합니다: `your-skill-name/`
3. 필수 파일을 작성합니다:

```
your-skill-name/
├── SKILL.md              # 필수: 스킬 정의 (YAML frontmatter + 내용)
├── README.md             # 권장: 설치 및 사용 가이드
├── install.sh            # 권장: 원격 설치 스크립트
└── references/           # 선택: 추가 레퍼런스 문서
    └── *.md
```

4. `SKILL.md` 형식:

```yaml
---
name: your-skill-name
description: 스킬에 대한 간단한 설명
---

# 스킬 제목

스킬 내용...
```

5. Pull Request를 생성합니다

### 코드 스타일

- Markdown 파일은 명확하고 간결하게 작성
- 코드 예제는 실행 가능한 상태로 제공
- 하드코딩된 경로 사용 금지 (이식성 보장)

### Pull Request 가이드라인

- 명확한 제목과 설명 작성
- 스킬 테스트 완료 후 제출
- 관련 이슈가 있다면 연결

---

## Uninstall

스킬을 제거하려면:

```bash
rm -rf ~/.claude/skills/<skill-name>
```

---

## License

이 프로젝트는 [Apache License 2.0](LICENSE) 하에 배포됩니다.

---

## Support

- **Issues**: [GitHub Issues](https://github.com/tolerant-Seoul/skills/issues)
- **Discussions**: [GitHub Discussions](https://github.com/tolerant-Seoul/skills/discussions)

---

## Acknowledgments

- [Claude Code](https://claude.ai/code) by Anthropic
- 모든 기여자분들께 감사드립니다
