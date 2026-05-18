import { LoginForm } from './login-form'

export default function LoginPage() {
  return (
    <div
      className="min-h-screen flex items-center justify-center"
      style={{ background: 'linear-gradient(135deg, #0F172A 0%, #1A4FA0 45%, #E8581A 100%)' }}
    >
      <div className="w-full max-w-[440px] px-4">
        <LoginForm />
      </div>
    </div>
  )
}
