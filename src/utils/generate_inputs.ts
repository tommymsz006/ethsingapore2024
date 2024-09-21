const { generateEmailVerifierInputs } = require("@zk-email/helpers");

export async function generateCircuitInputs(rawEmail: string, /*inputs: any*/) {
    const circuitInputs = await generateEmailVerifierInputs(rawEmail, {
        ignoreBodyHashCheck: true,
        maxBodyLength: 0,
        maxHeaderLength: 1024,
        shaPrecomputeSelector: "",
    });

    //const emailBodyString = circuitInputs.emailBody ? Buffer.from(circuitInputs.emailBody.map(Number)).toString('ascii') : '';
    const emailHeaderString: string | null = circuitInputs.emailHeader ? Buffer.from(circuitInputs.emailHeader.map(Number)).toString('ascii') : '';
    let regexInputs = {};

    let match = emailHeaderString.match(new RegExp("subject:=\\?UTF-8\\?B\\?WW91ciBlVGlja2V0IGlzIHJlYWR5OiB1c2UgYm9va2luZyByZWYg"));

    //console.log(match[0]);
    regexInputs = {
        ...regexInputs,
        bookingRefRegexIdx: match ? (match.index || 0) + match[0].length : 0
    };

    const packedInputs = {};

    return {
        ...circuitInputs,
        ...regexInputs,
        ...packedInputs
    }
}