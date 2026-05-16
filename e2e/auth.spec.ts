import { test, expect } from '@playwright/test'

test('unauthenticated user is redirected to login', async ({ page }) => {
  await page.goto('/')
  await expect(page).toHaveURL(/.*\/login/)
})

test('login page renders form elements', async ({ page }) => {
  await page.goto('/login')
  await expect(page.getByRole('heading', { name: 'Sign in' })).toBeVisible()
  await expect(page.getByLabel('Email')).toBeVisible()
  await expect(page.getByLabel('Password')).toBeVisible()
  await expect(page.getByRole('button', { name: 'Sign in' })).toBeVisible()
})

test('shows error for invalid credentials', async ({ page }) => {
  await page.goto('/login')
  await page.getByLabel('Email').fill('wrong@example.com')
  await page.getByLabel('Password').fill('wrongpassword')
  await page.getByRole('button', { name: 'Sign in' }).click()
  await expect(page.getByRole('alert')).toContainText('Invalid email or password')
})

test('authenticated user is redirected away from login page', async ({ page }) => {
  if (!process.env.TEST_USER_EMAIL) {
    test.skip(true, 'TEST_USER_EMAIL not configured — skipping auth test')
    return
  }
  // Log in first
  await page.goto('/login')
  await page.getByLabel('Email').fill(process.env.TEST_USER_EMAIL ?? '')
  await page.getByLabel('Password').fill(process.env.TEST_USER_PASSWORD ?? '')
  await page.getByRole('button', { name: 'Sign in' }).click()
  await expect(page).toHaveURL('/')

  // Visiting /login while authenticated should redirect to /
  await page.goto('/login')
  await expect(page).toHaveURL('/')
})
