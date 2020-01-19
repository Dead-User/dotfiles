
FILE_TYPE=$1
OP=$2
shift 2
TYPE=$(
  if [ $FILE_TYPE = rust -a -e "Cargo.toml" ]; then
      echo cargo
  elif [ $FILE_TYPE = ocaml -a -e "dune" ]; then
      echo dune
  elif [ -e "Makefile" ]; then
      echo make
  elif [ -e "all.do" ]; then
      echo redo
  else
      echo Don\'t know how to $OP >&2
      exit 1
  fi)

 case $TYPE:$OP in
     "cargo:make" ) cargo build $*;;
     "cargo:run"  ) cargo run   $*;;
     "cargo:test" ) cargo test  $*;;
     "dune:make"  ) dune build  $*;;
     "dune:run"   ) dune exec   $*;;
     "dune:test" ) dune runtest $*;;
     "make:make" ) make         $*;;
     "redo:make" ) redo all.do  $*;;
     "*"         )
         echo Don\'t know how to $OP >&2
         exit 1;;
esac


