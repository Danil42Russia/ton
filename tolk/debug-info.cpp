#include "tolk.h"
#include <ast.h>
#include <compiler-state.h>
#include "ast-stringifier.h"

namespace tolk {

void insert_call_debug_info(AnyV origin, ASTNodeKind kind, CodeBlob& code, const std:: string& called_name, CallKind call_kind) {
  if (!G.settings.collect_source_map) {
    return;
  }

  insert_debug_info(origin, kind, code);
  if (G.settings.collect_source_map && G.source_map.size() > 0) {
    auto& last_entry = G.source_map.at(G.source_map.size() - 1);
    last_entry.entry_or_leave_name = called_name;
    if (call_kind == CallKind::BeforeFunctionCall) {
      last_entry.is_entry = true;
    }
    if (call_kind == CallKind::LeaveFunction) {
      last_entry.is_leave = true;
    }
    if (call_kind == CallKind::AfterFunctionCall) {
      last_entry.is_after_function_call = true;
    }
    if (call_kind == CallKind::EnterInlinedFunction) {
      last_entry.before_inlined_function_call = true;
    }
    if (call_kind == CallKind::LeaveInlinedFunction) {
      last_entry.after_inlined_function_call = true;
    }
  }
}

void insert_debug_info(AnyV origin, ASTNodeKind kind, CodeBlob& code, bool is_leave, std::string descr) {
  if (!G.settings.collect_source_map) {
    return;
  }

  if (kind == ast_artificial_aux_vertex) {
    return;
  }

#ifdef TOLK_DEBUG
  const auto last_op = std::find_if(code._vector_of_ops.rbegin(), code._vector_of_ops.rend(), [](const auto& it) {
    return it->cl != Op::_DebugInfo;
  });
  const Op* last_op_ptr = last_op != code._vector_of_ops.rend() ? *last_op : nullptr;
#endif

  auto& op = code.emplace_back(origin, Op::_DebugInfo);
  op.source_map_entry_idx = G.source_map.size();

  auto info = SourceMapEntry{};
  info.idx = op.source_map_entry_idx;
  info.descr = descr;

#ifdef TOLK_DEBUG
  if (last_op_ptr) {
    std::stringstream st;
    last_op_ptr->show(st, code.vars, "", 4);

    info.opcode = st.str();
  }
#endif

  info.ast_kind = ASTStringifier::ast_node_kind_to_string(kind);

  if (const SrcFile* src_file = origin->range.get_src_file(); src_file != nullptr) {
    const auto& pos = src_file->convert_offset(origin->range.get_start_offset());

    info.loc.file = src_file->realpath;
    info.loc.offset = origin->range.get_start_offset();
    info.loc.line = pos.line_no;
    info.loc.line_offset = is_leave;
    info.loc.col = pos.char_no - 1;
    info.loc.length = 1; // Once we have the actual length of node, we should use it here
  }

  info.func_name = code.fun_ref->name;
  std::string code_name = code.fift_name(code.fun_ref);
  if (code_name != info.func_name) {
    // If a function was inlined, `code.name` will contain the name of the function we are inlining into
    info.inlined_to_func_name = code_name;
  }
  info.func_inline_mode = code.fun_ref->inline_mode;

  G.source_map.push_back(info);
}

void insert_debug_info(AnyV v, CodeBlob& code) {
  insert_debug_info(v, v->kind, code, 0, "");
}

}
