return {
    {
        'nomnivore/ollama.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            -- 1. 코드에 더 적합한 모델로 변경합니다.
            --    먼저 터미널에서 `ollama pull codellama`를 실행하세요.
            model = "gemma3:12b", -- 7B 모델이 속도와 성능 균형이 좋습니다.

            -- Ollama 서버 주소 (로컬 기본값)
            url = "http://10.10.40.171:11434",

            -- 인라인 자동완성을 원할 때만 수동으로 호출하려면 이 부분을 주석 처리하거나 false로 두세요.
            -- inline_auto_trigger = true,

            prompts = {
                -- 코드 생성 프롬프트 (Ollama)
                generate = {
                    prompt = "[INST] 당신은 전문 프로그래머입니다. 사용자의 지시에 따라 코드를 작성해주세요. 다른 설명 없이 코드만 간결하게 작성해주세요. 언어: `$ftype`, 지시: `$input` [/INST]",
                    stream = true,
                },
                -- 인라인 코드 편집 및 완성 프롬프트 (Ollama inline)
                inline = {
                    prompt = "[INST] 당신은 코드 에디터입니다. 사용자가 선택한 코드를 지시에 따라 수정하거나, 지시가 없다면 이어지는 코드를 작성해주세요. 다른 설명 없이 코드만 간결하게 작성해주세요. 선택된 코드: ```$sel```, 지시: `$input` [/INST]",
                    stream = true,
                },
                -- 'chat' 이라는 이름의 프롬프트를 정의
                chat = {
                    prompt = "[INST] 당신은 유용한 프로그래밍 어시스턴트입니다. 항상 한국어로 대답해주세요. 아래에 사용자의 질문이 있습니다. 사용자는 다음 코드를 컨텍스트로 제공했습니다. 응답에 컨텍스트를 반복하지 마세요. 컨텍스트: ```$buf```. 질문: $input [/INST]",
                    input_label = ">",
                    model = "gemma3:12b", -- 채팅에 사용할 모델
                    stream = true, -- 실시간으로 답변을 스트리밍
                },

                -- (예시) 이런 식으로 자신만의 프롬프트를 추가할 수 있습니다.
                summarize = {
                    prompt = "Summarize the following code: ```{{context}}```",
                    stream = true,
                },
            },
        },
        -- 2. 사용하기 편한 키맵을 설정합니다.
        keys = {
            -- Normal 모드에서: 주석으로 명령 내리고 실행하면 코드 생성
            {
                "<leader>ao",
                ":Ollama<CR>",
                desc = "Ollama: Generate code"
            },
            -- Visual 모드에서: 코드 선택 후 실행하여 수정/리팩토링 요청
            {
                "<leader>ai",
                ":Ollama inline<CR>",
                mode = { "n", "v" },
                desc = "Ollama: Inline edit/completion"
            },
            -- 코드에 대해 질문하는 채팅 창 열기
            {
                "<leader>ac",
                ":Ollama chat<CR>",
                desc = "Ollama: Chat"
            },
            -- 인라인 제안 수락/거부
            {
                "<C-l>", -- 다음 제안 (L)
                function() require("ollama").next_choice() end,
                mode = "i",
                desc = "Ollama: Next Choice"
            },
            {
                "<C-h>", -- 이전 제안 (H)
                function() require("ollama").prev_choice() end,
                mode = "i",
                desc = "Ollama: Previous Choice"
            },
            {
                "<C-j>", -- 제안 수락 (J)
                function() require("ollama").accept_choice() end,
                mode = "i",
                desc = "Ollama: Accept Choice"
            },
            {
                "<C-k>", -- 제안 닫기 (K)
                function() require("ollama").dismiss() end,
                mode = "i",
                desc = "Ollama: Dismiss"
            }
        }
    },
}
