rule simple_cat:
    input:
        "data/atext",
        "data/btext"
    output:
        expand("{home}/snakemake.output/nocommentstext", home=os.environ["HOME"])
    shell:
        "cat {input} | grep -v '#' > {output}"
