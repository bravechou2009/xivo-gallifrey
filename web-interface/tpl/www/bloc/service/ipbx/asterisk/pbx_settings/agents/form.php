<?php
	$form = &$this->get_module('form');
	$url = &$this->get_module('url');

	$element = $this->get_var('element');
	$info = $this->get_var('info');

	$agents = $this->get_var('agents');
	$agent_unslt = $this->get_var('agent_unslt');
	$agent_slt = $this->get_var('agent_slt');

	$deletable = $this->get_varra('info',array('agroup','deletable'));

	$queues = $this->get_var('queues');
	$qmember_slt = $this->get_var('qmember_slt');
	$qmember_unslt = $this->get_var('qmember_unslt');
?>

<div id="sb-part-first">

<?=$form->text(array('desc' => $this->bbf('fm_agentgroup_name'),'name' => 'agroup[name]','labelid' => 'agroup-name','size' => 15,'default' => $element['agroup']['name']['default'],'value' => $info['agroup']['name']));?>

<?php
	if($agents !== false):
?>

<div id="agentlist" class="fm-field fm-multilist"><p><label id="lb-agentlist" for="it-agentlist"><?=$this->bbf('fm_agents');?></label></p>
	<div class="slt-outlist">
		<?=$form->select(array('name' => 'agentlist','label' => false,'id' => 'it-agentlist','browse' => 'sort','key' => 'identity','altkey' => 'id','multiple' => true,'size' => 5,'field' => false),$agent_unslt);?>
	</div>
	<div class="inout-list">

		<a href="#" onclick="xivo_fm_move_selected('it-agentlist','it-agent'); return(xivo_free_focus());" title="<?=$this->bbf('bt_inagent');?>"><?=$url->img_html('img/site/button/row-left.gif',$this->bbf('bt_inagent'),'class="bt-inlist" id="bt-inagent" border="0"');?></a><br />

		<a href="#" onclick="xivo_fm_move_selected('it-agent','it-agentlist'); return(xivo_free_focus());" title="<?=$this->bbf('bt_outagent');?>"><?=$url->img_html('img/site/button/row-right.gif',$this->bbf('bt_outagent'),'class="bt-outlist" id="bt-outagent" border="0"');?></a>
	</div>
	<div class="slt-inlist">

		<?=$form->select(array('name' => 'agent-select[]','label' => false,'id' => 'it-agent','browse' => 'sort','key' => 'identity','altkey' => 'id','multiple' => true,'size' => 5,'field' => false),$agent_slt);?>

		<div class="bt-updown">

			<a href="#" onclick="xivo_fm_order_selected('it-agent',1); return(xivo_free_focus());" title="<?=$this->bbf('bt_upagent');?>"><?=$url->img_html('img/site/button/row-up.gif',$this->bbf('bt_upagent'),'class="bt-uplist" id="bt-upagent" border="0"');?></a><br />

			<a href="#" onclick="xivo_fm_order_selected('it-agent',-1); return(xivo_free_focus());" title="<?=$this->bbf('bt_downagent');?>"><?=$url->img_html('img/site/button/row-down.gif',$this->bbf('bt_downagent'),'class="bt-downlist" id="bt-downagent" border="0"');?></a>

		</div>

	</div>
</div>
<div class="clearboth"></div>
<?php
	endif;
?>
</div>

<div id="sb-part-last" class="b-nodisplay">

<?php
	if($queues !== false && ($nb = count($queues)) !== 0):
?>
	<div id="queuelist" class="fm-field fm-multilist">
		<div class="slt-outlist">

		<?=$form->select(array('name' => 'queuelist','label' => false,'id' => 'it-queuelist','multiple' => true,'size' => 5,'field' => false,'key' => false),$qmember_unslt);?>

		</div>
		<div class="inout-list">

			<a href="#" onclick="xivo_ast_inqueue(); return(xivo_free_focus());" title="<?=$this->bbf('bt_inqueue');?>"><?=$url->img_html('img/site/button/row-left.gif',$this->bbf('bt_inqueue'),'class="bt-inlist" id="bt-inqueue" border="0"');?></a><br />

			<a href="#" onclick="xivo_ast_outqueue(); return(xivo_free_focus());" title="<?=$this->bbf('bt_outqueue');?>"><?=$url->img_html('img/site/button/row-right.gif',$this->bbf('bt_outqueue'),'class="bt-outlist" id="bt-outqueue" border="0"');?></a>

		</div>
		<div class="slt-inlist">

		<?=$form->select(array('name' => 'queue-select[]','label' => false,'id' => 'it-queue','multiple' => true,'size' => 5,'field' => false,'key' => 'queue_name','altkey' => 'queue_name'),$qmember_slt);?>

		</div>
	</div>

	<div class="clearboth sb-list">
		<table cellspacing="0" cellpadding="0" border="0">
			<tr class="sb-top">
				<th class="th-left"><?=$this->bbf('col_queue-name');?></th>
				<th class="th-right"><?=$this->bbf('col_queue-penalty');?></th>
			</tr>
<?php
		for($i = 0;$i < $nb;$i++):
			$ref = &$queues[$i];
			$name = &$ref['queue']['name'];
			$class = ' b-nodisplay';
			$penalty = '';

			if(isset($ref['member']) === true && $ref['member'] !== false):
				$class = '';
				$penalty = (int) $ref['member']['penalty'];
			else:
				$ref['member'] = null;
			endif;
?>
			<tr id="queue-<?=$name?>" class="fm-field<?=$class?>">
				<td class="td-left txt-center"><?=$name?></td>
				<td class="td-right txt-center"><?=$form->select(array('field' => false,'name' => 'queue['.$name.'][penalty]','id' => false,'label' => false,'default' => $element['qmember']['penalty']['default'],'value' => $penalty),$element['qmember']['penalty']['value']);?></td>
			</tr>
<?php
		endfor;
?>
			<tr id="no-queue"<?=($qmember_slt !== false ? ' class="b-nodisplay"' : '')?>>
				<td colspan="2" class="td-single"><?=$this->bbf('no_queue');?></td>
			</tr>
		</table>
	</div>
<?php
	else:
		echo '<div class="txt-center">',$url->href_html($this->bbf('create_queue'),'service/ipbx/pbx_settings/queues','act=add'),'</div>';
	endif;
?>

</div>
