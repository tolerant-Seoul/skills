# Contributing to Claude Code Skills

기여해 주셔서 감사합니다! 이 문서는 기여 방법을 안내합니다.

## 기여 방법

### 버그 리포트

1. [Issues](https://github.com/tolerant-Seoul/skills/issues)에서 이미 보고된 버그인지 확인
2. 새 이슈 생성 시 다음 정보 포함:
   - 스킬 이름
   - 재현 단계
   - 예상 동작 vs 실제 동작
   - Claude Code 버전

### 새 스킬 제안

1. [Discussions](https://github.com/tolerant-Seoul/skills/discussions)에서 아이디어 공유
2. 커뮤니티 피드백 수집
3. 승인 후 개발 진행

### Pull Request

1. Fork 후 feature 브랜치 생성
   ```bash
   git checkout -b feat/new-skill-name
   ```

2. 변경사항 커밋
   ```bash
   git commit -m "feat: add new-skill-name skill"
   ```

3. Push 후 PR 생성
   ```bash
   git push origin feat/new-skill-name
   ```

## 스킬 작성 가이드

### 필수 파일

```
skill-name/
├── SKILL.md          # 스킬 정의 (필수)
└── README.md         # 설치 가이드 (권장)
```

### SKILL.md 형식

```yaml
---
name: skill-name
description: 한 줄 설명
---

# 스킬 제목

## Overview
스킬 개요

## 주요 기능
- 기능 1
- 기능 2

## 사용 예시
코드 예제...
```

### 품질 체크리스트

- [ ] 하드코딩된 경로 없음 (이식성)
- [ ] 코드 예제 실행 가능
- [ ] 명확한 설명과 문서화
- [ ] install.sh 테스트 완료
- [ ] 다른 OS에서 설치 테스트

## 커밋 메시지 규칙

```
feat: 새 기능 추가
fix: 버그 수정
docs: 문서 수정
refactor: 코드 리팩토링
```

## 코드 리뷰

모든 PR은 리뷰 후 머지됩니다:
- 스킬 구조 확인
- 이식성 검증
- 문서 완성도 체크

## 질문

질문이 있으시면 [Discussions](https://github.com/tolerant-Seoul/skills/discussions)를 이용해 주세요.
