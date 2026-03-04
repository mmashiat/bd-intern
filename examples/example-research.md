# CloudKitchen Research

**Date**: 2026-02-15
**Researcher**: BD Intern Agent
**Relationship Type**: Warm intro (via investor overlap)
**Product Interest**: NovaPay Connect

---

## Executive Summary
- CloudKitchen operates 300+ ghost kitchen locations across 12 US cities
- Series C ($180M) closed Jan 2026, led by Tiger Global
- Currently using legacy payment processor (Worldpay) with high fees and slow settlement
- Strong fit for NovaPay Connect — multi-location payment aggregation is their core pain
- Recommended approach: lead with faster settlement (T+1 vs T+3) and per-location reporting

## Company Overview

| Field | Detail |
|-------|--------|
| Founded | 2022 |
| HQ | Austin, TX |
| Headcount | ~450 |
| Funding | $240M total (Series A: $20M, B: $40M, C: $180M) |
| Website | cloudkitchen.example.com |

CloudKitchen operates ghost kitchens as a platform — restaurant brands rent kitchen space and CloudKitchen handles ordering, payments, and delivery logistics.

## Product & Technology

### What They Build
Multi-tenant ghost kitchen management platform. Handles order routing, kitchen scheduling, delivery dispatch, and payment processing across all locations.

### How It Works
- Orders come in via DoorDash, UberEats, direct website, and in-house app
- Unified order management system routes to correct kitchen station
- Payment aggregation across all order channels

### Stack
- Backend: Go microservices on AWS EKS
- Frontend: React + React Native
- Database: PostgreSQL + Redis
- Payments: Worldpay (legacy, migrating)

## Market Position

### Segment
Ghost kitchen infrastructure / restaurant-tech

### Competitors
- Kitchen United, Reef Technology, CUDO Kitchens

### Partnerships
- DoorDash (preferred partner), Uber Eats, GrubHub integration
- AWS startup program

### Customers
- 50+ restaurant brands using their platform
- 3 enterprise clients (unnamed fast-food chains)

## Key People

| Name | Role | Notable |
|------|------|---------|
| Sarah Chen | CEO & Co-founder | Ex-DoorDash product lead. Spoke at TechCrunch Disrupt 2025. |
| Marcus Johnson | CTO | Ex-Stripe engineer. Published on payment aggregation patterns. |
| Priya Patel | VP Operations | Runs all 300+ locations. Key decision-maker for vendor selection. |

## Product Fit Assessment

| Product | Fit | Rationale |
|---------|-----|-----------|
| NovaPay Connect | **High** | Multi-location payment aggregation is exactly what Connect solves. Legacy Worldpay integration is a pain point. |
| NovaPay Capital | Medium | Could offer working capital to restaurant brands on their platform. Secondary opportunity. |

### Strongest Fit
NovaPay Connect — their #1 payment pain is slow settlement and lack of per-location reporting with Worldpay. Connect solves both directly.

### Recommended Approach
Lead with faster settlement (T+1) and per-location financial reporting. Marcus (CTO) is ex-Stripe, so he'll appreciate the API design. Avoid feature-dumping — focus on the 2-3 things that matter for ghost kitchens.

## Sources
1. cloudkitchen.example.com/about — company overview
2. TechCrunch — "CloudKitchen raises $180M Series C" (Jan 2026)
3. Marcus Johnson's blog — "Payment aggregation at scale" (Nov 2025)
4. LinkedIn — headcount and team growth data

## Gaps & Open Questions
- What's their current Worldpay contract term? (migration timing)
- Are they evaluating other payment providers?
- What's the decision-making process — CTO-led or committee?
- Any regulatory requirements for multi-state food service payments?
