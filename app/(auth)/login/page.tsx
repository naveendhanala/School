import { LoginForm } from './login-form'

export default function LoginPage() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50">
      <div className="w-full max-w-md px-4">
        <div className="text-center mb-8">
          <h1 className="text-2xl font-bold text-gray-900">Rama School of Excellence</h1>
          <p className="text-sm text-gray-500 mt-1">Staff Portal</p>
        </div>
        <LoginForm />
      </div>
    </div>
  )
}
