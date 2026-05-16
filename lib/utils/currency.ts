// Indian number grouping: last 3 digits, then groups of 2 (e.g. 1,00,000).
// Uses regex instead of toLocaleString to avoid ICU data gaps in Node.js test env.
export function formatCurrency(amount: number): string {
  const fixed = amount.toFixed(2)
  const [whole, dec] = fixed.split('.')
  const lastThree = whole.slice(-3)
  const rest = whole.slice(0, -3)
  const grouped = rest
    ? rest.replace(/\B(?=(\d{2})+(?!\d))/g, ',') + ',' + lastThree
    : lastThree
  return `₹${grouped}.${dec}`
}
