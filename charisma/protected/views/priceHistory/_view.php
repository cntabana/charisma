<div class="view">

	<?php echo GxHtml::encode($data->getAttributeLabel('id')); ?>:
	<?php echo GxHtml::link(GxHtml::encode($data->id), array('view', 'id' => $data->id)); ?>
	<br />

	<?php echo GxHtml::encode($data->getAttributeLabel('iddrug')); ?>:
		<?php echo GxHtml::encode(GxHtml::valueEx($data->iddrug0)); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('ancient_price')); ?>:
	<?php echo GxHtml::encode($data->ancient_price); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('new_price')); ?>:
	<?php echo GxHtml::encode($data->new_price); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('old_changedate')); ?>:
	<?php echo GxHtml::encode($data->old_changedate); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('changedate')); ?>:
	<?php echo GxHtml::encode($data->changedate); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('userid')); ?>:
		<?php echo GxHtml::encode(GxHtml::valueEx($data->user)); ?>
	<br />

</div>