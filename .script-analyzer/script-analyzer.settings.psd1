
<#
    Use the PowerShell extension setting
    `powershell.scriptAnalysis.settingsPath` to get the current
    workspace to use this .script-analyzer.psd1 file to
    configure code analysis in Visual Studio Code. This setting
    is configured in the workspace's `.vscode\settings.json`.

    For more information on PSScriptAnalyzer settings see:
    http://bit.ly/2By8GXB

    You can see the predefined PSScriptAnalyzer settings here:
    http://bit.ly/32JWwHi
#>

@{
    # Use Severity when you want to limit the generated
    # diagnostic records to a subset of: Error, Warning and
    # Information. Uncomment the following line if you only want
    # Errors and Warnings but not Information diagnostic
    # records.

    <# Severity = @(
        'Error',
        'Information',
        'Warning'
    ); #>

    # Analyze **only** the following rules. Use IncludeRules
    # when you want to invoke only a small subset of the default
    # rules.

    <# IncludeRules = @(
        'PSAvoidAssignmentToAutomaticVariable',
        'PSAvoidDefaultValueForMandatoryParameter',
        'PSAvoidDefaultValueSwitchParameter',
        'PSAvoidGlobalAliases',
        'PSAvoidGlobalFunctions',
        'PSAvoidGlobalVars',
        'PSAvoidInvokingEmptyMembers',
        'PSAvoidNullOrEmptyHelpMessageAttribute',
        'PSAvoidShouldContinueWithoutForce',
        'PSAvoidTrailingWhitespace',
        'PSAvoidUsingCmdletAliases',
        'PSAvoidUsingComputerNameHardcoded',
        'PSAvoidUsingDeprecatedManifestFields',
        'PSAvoidUsingEmptyCatchBlock',
        'PSAvoidUsingPlainTextForPassword',
        'PSAvoidUsingPositionalParameters',
        'PSAvoidUsingUsernameAndPasswordParams',
        'PSAvoidUsingWMICmdlet',
        'PSAvoidUsingWriteHost',
        'PSMisleadingBacktick',
        'PSMissingModuleManifestField',
        'PSPlaceCloseBrace',
        'PSPossibleIncorrectComparisonWithNull',
        'PSPossibleIncorrectUsageOfRedirectionOperator',
        'PSReservedCmdletChar',
        'PSReservedParams',
        'PSShouldProcess',
        'PSUseApprovedVerbs',
        'PSUseBOMForUnicodeEncodedFile',
        'PSUseCmdletCorrectly',
        'PSUseCorrectCasing',
        'PSUseDeclaredVarsMoreThanAssignments',
        'PSUseLiteralInitializerForHashtable',
        'PSUseOutputTypeCorrectly',
        'PSUsePSCredentialType',
        'PSUseShouldProcessForStateChangingFunctions',
        'PSUseSingularNouns',
        'PSUseSupportsShouldProcess',
        'PSUseUTF8EncodingForHelpFile'
    ); #>

    # Do not analyze the following rules. Use ExcludeRules when
    # you have commented out the IncludeRules settings above and
    # want to include all the default rules except for those you
    # exclude below. Note: if a rule is in both IncludeRules and
    # ExcludeRules, the rule will be excluded.

    ExcludeRules = @(
        'PSAvoidUsingConvertToSecureStringWithPlainText',
        'PSAvoidUsingInvokeExpression',
        'PSUseShouldProcessForStateChangingFunctions',
        'PSUseToExportFieldsInManifest',
        'PSUseConsistentIndentation'
    );

    # You can use the following entry to supply parameters to
    # rules that take parameters. For instance, the
    # PSAvoidUsingCmdletAliases rule takes a whitelist for
    # aliases you want to allow.

    Rules = @{
        PSAvoidLongLines = @{
            Enable = $true;
            LineLength = 120;
        };

        PSPlaceCloseBrace = @{
            Enable = $true;
            NoEmptyLineBefore = $false;
            IgnoreOneLineBlock = $true;
            NewLineAfter = $true;
        };

        PSPlaceOpenBrace = @{
            Enable = $true;
            OnSameLine = $false;
            NewLineAfter = $true;
            IgnoreOneLineBlock = $true;
        };

        PSProvideCommentHelp = @{
            Enable = $true;
            ExportedOnly = $false;
            BlockComment = $true;
            VSCodeSnippetCorrection = $false;
            Placement = 'begin';
        };

        # PSUseConsistentIndentation = @{
        #     Enable = $true;
        #     IndentationSize = 4;
        #     PipelineIndentation = 'IncreaseIndentationForFirstPipeline';
        #     Kind = 'space';
        # };

        PSUseConsistentWhitespace = @{
            Enable = $true;
            CheckInnerBrace = $true;
            CheckOpenBrace = $false;
            CheckOpenParen = $true;
            CheckOperator = $true;
            CheckPipe = $true;
            CheckSeparator = $true;
        };
    };
}
