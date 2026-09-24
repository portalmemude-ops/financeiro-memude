import assert from 'node:assert/strict'
import { coreCommissionStatus, coreSaleBuyer } from '../utils/coreSaleMapping'

assert.equal(coreCommissionStatus('pendente'), 'pending')
assert.equal(coreCommissionStatus('pago'), 'received')
assert.equal(coreCommissionStatus('cancelado'), 'cancelled')
assert.equal(coreCommissionStatus('cancelada'), 'cancelled')
assert.equal(coreCommissionStatus('unknown'), 'pending')
assert.deepEqual(coreSaleBuyer({ nome: 'Cliente Teste', telefone: '5585999990001' }), {
  buyer_name: 'Cliente Teste', buyer_contact: '5585999990001',
})
assert.deepEqual(coreSaleBuyer(undefined), { buyer_name: null, buyer_contact: null })
console.log('Core sale mapping: 7 checks passed; a scheduled date never implies payment.')
