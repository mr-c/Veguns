#!/usr/env/bin cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: Construct a genome graph
doc: Includes all genome paths

hints:
  DockerRequirement:
    dockerPull: quay.io/vgteam/vg:dev-v1.12.1-51-g28ef4e32-t258-run
  SoftwareRequirement:
    packages:
      vg:
        version: ["1.12.1"]
        specs: [ https://doi.org/10.1038/nbt.4227 ]
#  ResourceRequirement:
#    coresMin: 1  # default!

inputs:
  fastas:
    type: File
    # format: edam:format_1929  # we need a IRI/URI for FASTA format

baseCommand: [ vg, msga ]

arguments:
  - --circularize
  - prefix: --from
    valueFrom: $(inputs.fastas)
  - prefix: --threads
    valueFrom: $(runtime.cores)

stdout: $(inputs.fastas.nameroot).vg

outputs:
  genome_graph: stdout
  # same as
  # genome_graph:
  #   type: File
  #   outputBinding:
  #     glob: $(inputs.reference_genome.nameroot)_$(inputs.genomic_varients.nameroot).vg

$namespaces:
  edam: http://edamontology.org/
