
    <div class="flex flex-col gap-6">
        <x-auth-header 
            :title="__('Verificar código')" 
            :description="__('Digite o código de 6 dígitos enviado para ' . $this->getMaskedPhone())" 
        />

        <!-- Error Message -->
        @if($error)
            <div class="p-3 text-sm text-red-600 bg-red-50 rounded-lg dark:bg-red-900/20 dark:text-red-400">
                {{ $error }}
            </div>
        @endif

        <div 
            class="flex flex-col gap-6"
            x-data="{
                digits: ['', '', '', '', '', ''],
                
                init() {
                     setTimeout(() => document.getElementById('digit-0').focus(), 100);
                },

                get code() {
                    return this.digits.join('');
                },

                get isComplete() {
                    return this.code.length === 6;
                },

                handleInput(index, e) {
                    const value = e.target.value.replace(/\D/g, '');
                    this.digits[index] = value.slice(-1);
                    
                    if (value && index < 5) {
                        document.getElementById('digit-' + (index + 1)).focus();
                    }
                },
                
                handleKeydown(index, e) {
                    if (e.key === 'Backspace') {
                        if (!this.digits[index] && index > 0) {
                            document.getElementById('digit-' + (index - 1)).focus();
                        } else {
                            this.digits[index] = '';
                        }
                    }
                    
                    if (e.key === 'Enter' && this.isComplete) {
                        this.submit();
                    }
                },
                
                handlePaste(e) {
                    e.preventDefault();
                    const paste = (e.clipboardData || window.clipboardData).getData('text');
                    const nums = paste.replace(/\D/g, '').slice(0, 6).split('');
                    
                    nums.forEach((n, i) => {
                        if (i < 6) this.digits[i] = n;
                    });
                    
                    if (nums.length >= 6) {
                        document.getElementById('digit-5').focus();
                    }
                },

                submit() {
                    if (!this.isComplete) return;
                    
                    // Dispatch Livewire event instead of calling methods directly
                    $dispatch('verify-code-submitted', { code: this.code });
                }
            }"
        >
            <!-- 6-Digit Code Input -->
            <div class="flex flex-col gap-3">
                <label style="font-size: 14px; font-weight: 500; color: #374151;">
                    Código de verificação
                </label>
                
                <div style="display: flex; justify-content: center; gap: 8px;">
                    <input type="text" inputmode="numeric" maxlength="1" id="digit-0" x-model="digits[0]" @input="handleInput(0, $event)" @keydown="handleKeydown(0, $event)" @paste="handlePaste($event)" style="width: 48px; height: 56px; font-size: 24px; font-weight: bold; text-align: center; border: 2px solid #d1d5db; border-radius: 8px; background-color: #fff; color: #111;" class="focus:ring-2 focus:ring-blue-500 focus:outline-none transition-all" />
                    <input type="text" inputmode="numeric" maxlength="1" id="digit-1" x-model="digits[1]" @input="handleInput(1, $event)" @keydown="handleKeydown(1, $event)" @paste="handlePaste($event)" style="width: 48px; height: 56px; font-size: 24px; font-weight: bold; text-align: center; border: 2px solid #d1d5db; border-radius: 8px; background-color: #fff; color: #111;" class="focus:ring-2 focus:ring-blue-500 focus:outline-none transition-all" />
                    <input type="text" inputmode="numeric" maxlength="1" id="digit-2" x-model="digits[2]" @input="handleInput(2, $event)" @keydown="handleKeydown(2, $event)" @paste="handlePaste($event)" style="width: 48px; height: 56px; font-size: 24px; font-weight: bold; text-align: center; border: 2px solid #d1d5db; border-radius: 8px; background-color: #fff; color: #111;" class="focus:ring-2 focus:ring-blue-500 focus:outline-none transition-all" />
                    <input type="text" inputmode="numeric" maxlength="1" id="digit-3" x-model="digits[3]" @input="handleInput(3, $event)" @keydown="handleKeydown(3, $event)" @paste="handlePaste($event)" style="width: 48px; height: 56px; font-size: 24px; font-weight: bold; text-align: center; border: 2px solid #d1d5db; border-radius: 8px; background-color: #fff; color: #111;" class="focus:ring-2 focus:ring-blue-500 focus:outline-none transition-all" />
                    <input type="text" inputmode="numeric" maxlength="1" id="digit-4" x-model="digits[4]" @input="handleInput(4, $event)" @keydown="handleKeydown(4, $event)" @paste="handlePaste($event)" style="width: 48px; height: 56px; font-size: 24px; font-weight: bold; text-align: center; border: 2px solid #d1d5db; border-radius: 8px; background-color: #fff; color: #111;" class="focus:ring-2 focus:ring-blue-500 focus:outline-none transition-all" />
                    <input type="text" inputmode="numeric" maxlength="1" id="digit-5" x-model="digits[5]" @input="handleInput(5, $event)" @keydown="handleKeydown(5, $event)" @paste="handlePaste($event)" style="width: 48px; height: 56px; font-size: 24px; font-weight: bold; text-align: center; border: 2px solid #d1d5db; border-radius: 8px; background-color: #fff; color: #111;" class="focus:ring-2 focus:ring-blue-500 focus:outline-none transition-all" />
                </div>
            </div>

            <div class="flex items-center justify-end">
                <button 
                    type="button"
                    @click="submit"
                    :disabled="!isComplete"
                    class="transition-all duration-200"
                    style="width: 100%; padding: 10px 16px; font-size: 14px; font-weight: 500; color: #fff; 
                           border: none; border-radius: 8px;"
                    :style="{
                        backgroundColor: isComplete ? '#2563eb' : '#9ca3af',
                        cursor: isComplete ? 'pointer' : 'not-allowed',
                        opacity: isComplete ? '1' : '0.6'
                    }"
                >
                    <span wire:loading.remove wire:target="verifyCode">Verificar</span>
                    <span wire:loading wire:target="verifyCode">Verificando...</span>
                </button>
            </div>
        </div>

        <!-- Resend Code -->
        <div class="text-center">
            @if($resendCountdown > 0)
                <p style="font-size: 14px; color: #6b7280;">
                    Reenviar código em <span style="font-weight: 500;">{{ $resendCountdown }}</span> segundos
                </p>
            @else
                <button 
                    type="button"
                    wire:click="resendCode"
                    wire:loading.attr="disabled"
                    style="font-size: 14px; color: #2563eb; background: none; border: none; cursor: pointer; text-decoration: underline;"
                >
                    Reenviar código
                </button>
            @endif
        </div>

        <!-- Back to phone input -->
        <div class="text-center">
            <a href="{{ route('login') }}" wire:navigate style="font-size: 14px; color: #6b7280; text-decoration: none;">
                ← Alterar número
            </a>
        </div>
    </div>
</div>
